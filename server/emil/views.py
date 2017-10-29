from django.core.exceptions import ObjectDoesNotExist
from rest_framework import viewsets
from rest_framework.exceptions import ValidationError
import json
from rest_framework.response import Response
from datetime import timedelta
from .serializer import *


class UserViewSet(viewsets.ViewSet):
    # queryset = User.objects.all()
    # serializer_class = UserSerializer

    @staticmethod
    def list(request):
        return Response({
            "random_id": "KQsRm2J6sj",
            "available_smileage": "0",
            "used_smileage": "0",
            "is_active": "true"
            })


class PostCafViewSet(viewsets.ViewSet):

    @staticmethod
    def create(request):
        if request.method == 'POST':
            serializer = PostCafSerializer(data=request.data)

            if serializer.is_valid():
                serializer = SoundSerializer(data=json.loads(request.data['sound']))

                if serializer.is_valid():
                    return Response({'result': 'OK'})
                else:
                    return Response(serializer.errors)
            else:
                return Response(serializer.errors)
        else:
            return Response('Not Allow GET method')


class GetWeeklyLaughViewSet(viewsets.ViewSet):

    @staticmethod
    def create(request):
        if request.method == 'POST':
            serializer = GetWeeklyLaughSerializer(data=request.data)

            if serializer.is_valid():
                try:
                    user = User.objects.get(random_id=request.data['user_id'])
                except ObjectDoesNotExist:
                    raise ValidationError(404)

                user_total_smileage = user.available_smileage

                start_y = int(request.data['start_year'])
                start_m = int(request.data['start_month'])
                start_d = int(request.data['start_day'])

                start_date = datetime.date(datetime(start_y, start_m, start_d))

                results = []
                for _ in range(7):
                    end_date = start_date + timedelta(days=1)
                    laugh = Laugh.objects.filter(created_at__range=(start_date, end_date), user=user)

                    results.append(str(len(laugh)))
                    start_date = end_date

                return Response({
                    'total_smileage': str(user_total_smileage),
                    'weekly': results
                })

            else:
                raise ValidationError(serializer.errors)


class GetTimetableLaughViewSet(viewsets.ViewSet):
    @staticmethod
    def create(request):
        if request.method == 'POST':
            serializer = GetTimetableLaughSerializer(data=request.data)

            if serializer.is_valid():
                try:
                    user = User.objects.get(random_id=request.data['user_id'])
                except ObjectDoesNotExist:
                    raise ValidationError(404)

            else:
                raise ValidationError(serializer.errors)
        else:
            raise ValidationError('Do not get method')


class SaveLaughViewSet(viewsets.ViewSet):
    @staticmethod
    def create(request):
        if request.method == 'POST':
            serializer = SaveLaughSerializer(data=request.data)

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