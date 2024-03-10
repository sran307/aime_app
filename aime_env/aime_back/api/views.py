from rest_framework import generics
from django.contrib.auth.models import User

from .models import deviceDetails
from .serializers import UserSerializer
from .serializers import checkDataSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from decoder import decode_data, verify_checksum
import json

# class Usercreate(generics.ListCreateAPIView):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# class AuthView(generics.GenericAPIView):
#     def deviceExist(self, request):
#         print(request)

@api_view(['POST'])
def checkDeviceExist(request):
    try:
        device_data = json.loads(request.body.decode('utf-8'))
    except json.JSONDecodeError:
        return Response({'error': 'Invalid JSON data'}, status=400)
    
    serializer = checkDataSerializer(data=device_data)
    if serializer.is_valid():
        base64_encoded_data = serializer.validated_data.get('encodedData')
        
        decodedData = decode_data(base64_encoded_data)
        deviceName = decodedData['deviceName']
        deviceId = decodedData['deviceId']

        try:
            isExist = deviceDetails.objects.filter(deviceName = deviceName, deviceId = deviceId).count()
            if(isExist > 0):
                return Response({
                    'status': 200,
                    'isExist': True
                })
            else:
                return Response({
                    'status': 400,
                    'isExist': False
                })
        except deviceDetails.DoesNotExist:
            return Response({
                'status': 400, 
                'isExist' : False,
                'isException': True
                })
    else:
        return Response(serializer.errors, status=400)
    
@api_view(['POST'])
def registerUser(request):
    try:
        device_data = json.loads(request.body.decode('utf-8'))
    except json.JSONDecodeError:
        return Response({'error': 'Invalid JSON data'}, status=400)
    serializer = checkDataSerializer(data=device_data)
    if serializer.is_valid():
        base64_encoded_data = serializer.validated_data.get('encodedData')
        
        decodedData = decode_data(base64_encoded_data)
        serializer = UserSerializer(data = decodedData)
        if serializer.is_valid():
            serializer.save()
            return Response(decodedData['password'])
        else:
            return Response(serializer.errors, status=400)   
    else:
        return Response(serializer.errors, status=400)