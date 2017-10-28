from django.http import JsonResponse
from rest_framework import viewsets
from rest_framework.exceptions import ValidationError
import json

from rest_framework.response import Response

from .models import *
from .serializer import *


class UserViewSet(viewsets.ModelViewSet):
    queryset = User.objects.all()
    serializer_class = UserSerializer


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
