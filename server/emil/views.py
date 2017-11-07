from django.core.exceptions import ObjectDoesNotExist
from django.http import JsonResponse
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


# class PostCafViewSet(viewsets.ViewSet):
#
#     @staticmethod
#     def create(request):
#         if request.method == 'POST':
#             serializer = PostCafSerializer(data=request.data)
#
#             if serializer.is_valid():
#                 serializer = SoundSerializer(data=json.loads(request.data['sound']))
#
#                 if serializer.is_valid():
#                     return Response({'result': 'OK'})
#                 else:
#                     return Response(serializer.errors)
#             else:
#                 return Response(serializer.errors)
#         else:
#             return Response('Not Allow GET method')


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

            return Response({
                'weekly': results
            })

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
            try:
                user = self.get_queryset()
            except ObjectDoesNotExist:
                raise ValidationError(404)

            # TODO
            return Response({
                0: [1, 2, 3],
                1: [1, 2, 3],
                2: [1, 2, 3],
                3: [1, 2, 3],
                4: [1, 2, 3],
                5: [1, 2, 3],
                6: [1, 2, 3]
            })

        else:
            raise ValidationError(serializer.errors)

    def get_queryset(self):
        return User.objects.get(id=self.kwargs.get('user_id'))


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