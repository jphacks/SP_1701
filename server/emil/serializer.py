from rest_framework import serializers
from .models import *


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('random_id', 'available_smileage', 'used_smileage', 'is_active')


class SoundSerializer(serializers.Serializer):
    content_type = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    filename = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    file_data = serializers.CharField(allow_blank=False, allow_null=False, required=True)


class PostCafSerializer(serializers.Serializer):
    sound = serializers.CharField(allow_blank=False, allow_null=False, required=True)
