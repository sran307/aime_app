from rest_framework import serializers
from django.contrib.auth.models import User

from .models import deviceDetails

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'first_name', 'email', 'password', 'username']

        extra_kwargs ={
            'password': {'write_only':True}
        }
        def create(self, validated_data):
            password = validated_data.pop('password', None)
            instance = self.Meta.model(**validated_data)
            if password is not None:
                instance.set_password(password)
            instance.save()
            
            return instance


class checkDataSerializer(serializers.Serializer):
    encodedData = serializers.CharField()
    # Checksum = serializers.CharField()

class deviceDetailsSerializer(serializers.ModelSerializer):
    class Meta:
        model = deviceDetails  # Specify the model here
        fields = ['deviceName', 'deviceId', 'userId', 'lastLoginAt']

