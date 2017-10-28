from rest_framework import serializers
from .models import *


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ('random_id', 'available_smileage', 'used_smileage', 'is_active')
