from rest_framework import serializers
from django.contrib.auth.models import User

from .models import deviceDetails

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = '__all__'


class checkDeviceSerializer(serializers.Serializer):
    encodedData = serializers.CharField()
    # Checksum = serializers.CharField()

class deviceDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model: deviceDetails
        fields = '__all__'