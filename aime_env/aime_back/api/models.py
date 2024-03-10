from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class deviceDetails(models.Model):
    userId = models.ForeignKey(User, on_delete = models.CASCADE, db_column = 'user_id')
    deviceName = models.CharField(max_length=15, db_column = 'device_name')
    deviceId = models.CharField(max_length = 255, db_column = 'device_id')
    registeredAt = models.DateTimeField(auto_now_add=True, db_column = 'registered_at')
    lastLoginAt = models.DateTimeField(db_column = 'last_login_at')

    class Meta:
        db_table = 'device_details'
        unique_together = ('deviceName', 'deviceId')


class User(User):
    firstName = models.CharField(max_length=30, db_column = 'first_name')
    username = None

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS =[]