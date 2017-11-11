import os
import base64
from django.core.exceptions import ObjectDoesNotExist
from rest_framework import viewsets
from rest_framework.exceptions import ValidationError
from rest_framework.response import Response
from datetime import timedelta
from .serializer import *



class UsersViewSet(viewsets.ModelViewSet):
    http_method_names = ['get']
    serializer_class = UserSerializer

    def list(self, request, **kwargs):
        try:
            user = self.get_queryset()
        except ObjectDoesNotExist:
            raise ValidationError(404)

        return Response({
            'available': user.available_smileage,
            'used': user.used_smileage
        })

    def get_queryset(self):
        return User.objects.get(id=self.kwargs.get('user_id'))


class LaughsViewSet(viewsets.ModelViewSet):
    http_method_names = ['get']
    serializer_class = LaughsSerializer

    def list(self, request, **kwargs):
        serializer = LaughsSerializer(data=kwargs)

        if serializer.is_valid():
            try:
                user = self.get_queryset()
            except ObjectDoesNotExist:
                raise ValidationError(404)

            start_y = int(kwargs.get('year'))
            start_m = int(kwargs.get('month'))
            start_d = int(kwargs.get('day'))

            start_date = datetime.date(datetime(start_y, start_m, start_d))

            results = []
            for _ in range(7):
                end_date = start_date + timedelta(days=1)
                laugh = Laugh.objects.filter(created_at__range=(start_date, end_date), user=user)

                results.append(len(laugh))
                start_date = end_date

            return Response({'weekly': results})

        else:
            raise ValidationError(serializer.errors)

    def get_queryset(self):
        return User.objects.get(id=self.kwargs.get('user_id'))


class LaughsDetailViewSet(viewsets.ModelViewSet):
    http_method_names = ['get']
    serializer_class = LaughsSerializer

    def list(self, request, **kwargs):

        serializer = LaughsSerializer(data=kwargs)

        if serializer.is_valid():

            weekday = datetime.strptime(kwargs.get('year') + '/' + kwargs.get('month') + '/' + kwargs.get('day'),
                                        '%Y/%m/%d').weekday()

            # 指定された日付が日曜日かをチェック
            if weekday != 6:
                raise ValidationError('日曜日の日付を指定する必要があります')

            try:
                user = self.get_queryset()
            except ObjectDoesNotExist:
                raise ValidationError(404)

            start_y = int(kwargs.get('year'))
            start_m = int(kwargs.get('month'))
            start_d = int(kwargs.get('day'))

            # 開始日と終了日のdateを生成
            start = datetime.date(datetime(start_y, start_m, start_d))
            end = start + timedelta(days=7)

            # まず、ユーザと開始・終了日で絞り込む
            laughs = Laugh.objects.filter(user=user, created_at__range=(start, end))

            # 時間割(http://www.city.funabashi.lg.jp/gakkou/0001/miyama-e/0003/p014319.html)
            timetable = [
                {'s': {'h': 8, 'm': 45}, 'e': {'h': 9, 'm': 30}},
                {'s': {'h': 9, 'm': 35}, 'e': {'h': 10, 'm': 20}},
                {'s': {'h': 10, 'm': 20}, 'e': {'h': 10, 'm': 40}},
                {'s': {'h': 10, 'm': 45}, 'e': {'h': 11, 'm': 30}},
                {'s': {'h': 11, 'm': 35}, 'e': {'h': 12, 'm': 20}},
                {'s': {'h': 12, 'm': 20}, 'e': {'h': 13, 'm': 50}},
                {'s': {'h': 13, 'm': 50}, 'e': {'h': 14, 'm': 35}},
                {'s': {'h': 14, 'm': 40}, 'e': {'h': 15, 'm': 40}},
                {'s': {'h': 15, 'm': 40}, 'e': {'h': 18, 'm': 0}},
            ]

            results = []

            # 時間割ごとのループ
            for one_class in timetable:

                # 1コマ分の開始・終了時間を生成
                start = datetime(start_y, start_m, start_d, one_class['s']['h'], one_class['s']['m'], 0)
                end = datetime(start_y, start_m, start_d, one_class['e']['h'], one_class['e']['m'], 0)

                day_laughs_by_one_class = []

                # 日にちのループ
                for _ in range(7):
                    # print(start, end, laughs.filter(created_at__range=(start, end)).count())

                    # 1コマに笑った回数を記録
                    day_laughs_by_one_class.append(
                        laughs.filter(created_at__range=(start + timedelta(hours=9), end + timedelta(hours=9))).count())

                    start = start + timedelta(days=1)
                    end = end + timedelta(days=1)

                # 1週間分、時間別の笑った回数を記録
                results.append(day_laughs_by_one_class)

            return Response(results)

        else:
            raise ValidationError(serializer.errors)

    def get_queryset(self):
        return User.objects.get(id=self.kwargs.get('user_id'))


class LaughViewSet(viewsets.ModelViewSet):
    http_method_names = ['post']
    serializer_class = LaughSerializer

    def create(self, request, *args, **kwargs):
        if request.method == 'POST':
            serializer = LaughSerializer(data=request.data)

            if serializer.is_valid():
                try:
                    user = User.objects.get(random_id=request.data['user_id'])
                except ObjectDoesNotExist:
                    raise ValidationError(404)

                Laugh.objects.create(user=user, created_at=datetime.now())

                return Response('OK')
            else:
                raise ValidationError(serializer.errors)
        else:
            raise ValidationError('Do not get method')

    def get_queryset(self):
        return User.objects.get(random_id=self.request.data['user_id'])


class SoundViewSet(viewsets.ModelViewSet):
    http_method_names = ['post']
    serializer_class = SoundSerializer

    def create(self, request, *args, **kwargs):
        if request.method == 'POST':
            sound_serializer = SoundSerializer(data=request.data)

            if not sound_serializer.is_valid():
                return Response(sound_serializer.errors)

            json_data = dict(request.data)

            # TODO 実際に受け取ったbase64をデコードして保存してみる

            # print(type(json_data['file_data']))
            # f = open('tmp/recording1.caf', 'rb')
            # encoded = base64.b64encode(f.read())
            # f.close()

            encoded = json_data['file_data']

            # 規定に合わせるために=で埋め合わせ
            missing_padding = len(encoded) % 4
            if missing_padding != 0:
                encoded += '=' * (4 - len(encoded) % 4)

            now = datetime.now()
            now_str = now.strftime('%Y-%m-%d %H:%M:%S')

            filename_caf = 'tmp/' + json_data['user_id'][0] + '_' + now_str + '.caf'

            f = open(filename_caf, 'wb')

            try:
                f.write(base64.b64decode(encoded))
                f.close()
            except ValueError:
                os.remove(filename_caf)
                raise ValueError(500)

            return Response(filename_caf)

    def get_queryset(self):
        return User.objects.get(id=self.request.data['user_id'])
