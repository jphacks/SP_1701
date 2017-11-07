from rest_framework import serializers
from .models import *


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('random_id', 'available_smileage', 'used_smileage')


class SoundSerializer(serializers.Serializer):
    content_type = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    filename = serializers.CharField(allow_blank=False, allow_null=False, required=True)
    file_data = serializers.CharField(allow_blank=False, allow_null=False, required=True)


class PostCafSerializer(serializers.Serializer):
    sound = serializers.CharField(allow_blank=False, allow_null=False, required=True)


class GetWeeklyLaughSerializer(serializers.Serializer):
    user_id = serializers.CharField(allow_null=False, allow_blank=False, required=True, max_length=10)
    start_year = serializers.IntegerField(allow_null=False, max_value=int(datetime.now().year), required=True)
    start_month = serializers.IntegerField(allow_null=False, min_value=1, max_value=12, required=True)
    start_day = serializers.IntegerField(allow_null=False, min_value=1, max_value=31, required=True)


class GetTimetableLaughSerializer(serializers.Serializer):
    user_id = serializers.CharField(allow_null=False, allow_blank=False, required=True, max_length=10)
    start_year = serializers.IntegerField(allow_null=False, max_value=int(datetime.now().year), required=True)
    start_month = serializers.IntegerField(allow_null=False, min_value=1, max_value=12, required=True)
    start_day = serializers.IntegerField(allow_null=False, min_value=1, max_value=31, required=True)


class SaveLaughSerializer(serializers.Serializer):
    user_id = serializers.CharField(allow_null=False, allow_blank=False, required=True, max_length=10)
