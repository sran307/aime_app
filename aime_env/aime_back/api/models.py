from django.db import models
from django.contrib.auth.models import AbstractUser
import uuid

class CustomUser(AbstractUser):
    guid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)

    def __str__(self):
        return self.username

class deviceDetails(models.Model):
    guid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, db_column='user_id')
    device_name = models.CharField(max_length=15, db_column='device_name')
    device_id = models.CharField(max_length=255, db_column='device_id')
    registered_at = models.DateTimeField(auto_now_add=True, db_column='registered_at')
    last_login_at = models.DateTimeField(db_column='last_login_at')

    class Meta:
        db_table = 'device_details'
        unique_together = ('device_name', 'device_id')

    def __str__(self):
        return self.device_name

class MetaData(models.Model):
    guid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, db_column='user_id')
    dateTime = models.DateTimeField(auto_now_add=True, db_column='date_time')
    deviceName = models.CharField(max_length=255, null=True, db_column='device_name')

    class Meta:
        db_table = 'meta_data'

class Todo(models.Model):
    guid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    user = models.ForeignKey(CustomUser, on_delete=models.CASCADE, db_column='user_id')
    todoName = models.CharField(max_length=255, db_column='todo_name')
    todoDate = models.DateTimeField(db_column='todo_date')
    isCompleted = models.BooleanField(default=False, db_column='is_completed')
    isRegular = models.BooleanField(default=False, db_column='is_regular')
    insertAt = models.ForeignKey(MetaData, on_delete=models.SET_NULL, null=True, db_column = 'insert_at', related_name='todo_inserts')
    updateAt = models.ForeignKey(MetaData, on_delete=models.SET_NULL, null=True, db_column = 'update_at', related_name='todo_updates')

    class Meta:
        db_table = 'todo'

    def __str__(self):
        return self.todoName