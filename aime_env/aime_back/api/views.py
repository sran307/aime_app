from rest_framework import generics
from django.contrib.auth.models import User
from .serializers import UserSerializer
from .serializers import checkDeviceSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from decoder import decode_data, verify_checksum
import json
import base64
import hashlib
# class Usercreate(generics.ListCreateAPIView):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# class AuthView(generics.GenericAPIView):
#     def deviceExist(self, request):
#         print(request)

@api_view(['POST'])
def checkDeviceExist(request):
    # return Response(request.data)
    try:
        device_data = json.loads(request.body.decode('utf-8'))
        # return Response(device_data)
        # device_data = json.loads(device_data)
        # return Response(device_data)
    except json.JSONDecodeError:
        return Response({'error': 'Invalid JSON data'}, status=400)
    
    serializer = checkDeviceSerializer(data=device_data)
    if serializer.is_valid():
        base64_encoded_data = serializer.validated_data.get('encodedData')
        checksum = serializer.validated_data.get('Checksum')
        # Do something with the data
        decodedData = decode_data(base64_encoded_data)
        isVerified = verify_checksum(decodedData, checksum)

        return Response(
            {
                'message': 'Data received successfully',
                'verified': isVerified,
                'data': decodedData
            })
    else:
        return Response(serializer.errors, status=400)