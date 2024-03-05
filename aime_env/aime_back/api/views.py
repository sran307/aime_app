from rest_framework import generics
from django.contrib.auth.models import User
from .serializers import UserSerializer
from .serializers import checkDeviceSerializer

from rest_framework.decorators import api_view
from rest_framework.response import Response
from decoder import decode_data, verify_checksum
# class Usercreate(generics.ListCreateAPIView):
#     queryset = User.objects.all()
#     serializer_class = UserSerializer

# class AuthView(generics.GenericAPIView):
#     def deviceExist(self, request):
#         print(request)

@api_view(['POST'])
def checkDeviceExist(request):
    serializer = checkDeviceSerializer(data=request.data)
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