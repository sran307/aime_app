from rest_framework import generics, status
from django.contrib.auth.models import User

from .models import deviceDetails
from .serializers import checkDataSerializer,UserSerializer, deviceDetailsSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from decoder import decode_data, verify_checksum
import json
from django.contrib.auth import authenticate
import jwt, datetime
from django.utils import timezone
from django.db import transaction
from encoder import hashUsername, hashPassword
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
        return Response({
                'status': 400, 
                'isExist' : False,
                'isException': True
                })
    
@api_view(['POST'])
def registerUser(request):
    try:
        device_data = json.loads(request.body.decode('utf-8'))
    except json.JSONDecodeError:
        return Response({'error': 'Invalid JSON data'}, status=400)
    
    serializer = checkDataSerializer(data=device_data)
    if serializer.is_valid():
        base64_encoded_data = serializer.validated_data.get('encodedData')
        decoded_data = decode_data(base64_encoded_data)

        pin = decoded_data.get('username')
        username = hashUsername(decoded_data.get('username'))
        password = hashPassword(decoded_data.get('password'), decoded_data.get('username'))
        user_data = {
            'first_name': decoded_data.get('first_name'),
            'email': decoded_data.get('email'),
            'password': password,
            'username': username
        }

        device_data = {
            'deviceName': decoded_data['deviceDetails']['deviceName'],
            'deviceId': decoded_data['deviceDetails']['deviceId']
        }

        # Validate and save user data
        user_serializer = UserSerializer(data=user_data)
        if user_serializer.is_valid():
            try:
                with transaction.atomic():  # Use transaction to ensure atomicity
                    user_instance = user_serializer.save()
                    device_data['userId'] = user_instance.id 
                    device_data['lastLoginAt']= timezone.now()
                    device_serializer = deviceDetailsSerializer(data=device_data)
                    if device_serializer.is_valid():
                        device_serializer.save()
                    else:
                        user_instance.delete()  # Rollback user creation if device creation fails
                        return Response(device_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
            except Exception as e:
                return Response(e, status=status.HTTP_400_BAD_REQUEST)
        else:
            return Response(user_serializer.errors, status=status.HTTP_400_BAD_REQUEST)

        return Response({'pin': pin}, status=status.HTTP_201_CREATED)
    else:
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
@api_view(['POST'])
def loginUser(request):
    try:
        device_data = json.loads(request.body.decode('utf-8'))
    except json.JSONDecodeError:
        return Response({'error': 'Inalid JSON data'}, status = 400)
    serializer = checkDataSerializer(data=device_data)
    serializer.is_valid(raise_exception=True)
    base64_encoded_data = serializer.validated_data.get('encodedData')
    decodedData = decode_data(base64_encoded_data)
    pin = decodedData['pin']
    username = hashUsername(pin)
    password = hashPassword(pin, pin)
    try:
        user = User.objects.filter(username = username, password=password)
        serializer = UserSerializer(user, many=True)
        id = 0
        for userData in serializer.data:
            id = userData['id']
        if(id != 0):
            payload = {
                'id': id,
                'exp':datetime.datetime.utcnow()+datetime.timedelta(minutes=1),
                'iat': datetime.datetime.utcnow()
            }
            token = jwt.encode(payload, 'secret', algorithm='HS256')
            return Response({
                'status':200,
                'token':token
                }, status=status.HTTP_201_CREATED) 
        else:
            return Response({
                'status':400,
                'message': 'Invalid Pin'
            }, status=status.HTTP_400_BAD_REQUEST)
    except User.DoesNotExist:
        return Response({
            'message': 'User not found',
        }, status=status.HTTP_400_BAD_REQUEST) 