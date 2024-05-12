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
    
class StockNames(models.Model):
    guid = models.UUIDField(default=uuid.uuid4, editable=False, unique=True)
    stockName = models.CharField(max_length=150, db_column='stock_name')
    stockCode = models.CharField(max_length=50, db_column='stock_code')
    yCode = models.CharField(max_length=50, db_column='yhoo_code')
    isActive = models.BooleanField(default=True, db_column='is_active')
    insertAt = models.ForeignKey(MetaData, on_delete=models.SET_NULL, null=True, db_column = 'insert_at', related_name='stock_inserts')
    updateAt = models.ForeignKey(MetaData, on_delete=models.SET_NULL, null=True, db_column = 'update_at', related_name='stock_updates')

    class Meta:
        db_table = 'stock_names'

    def __str__(self):
        return self.stockName
    
class TradeData(models.Model):
    stock = models.ForeignKey(StockNames, on_delete=models.SET_NULL, null=True, db_column = 'stock', related_name='stock_name')
    date = models.DateField(db_column='date')
    startDate = models.DateField(null=True,db_column='start_date')
    endDate = models.DateField(null=True,db_column='end_date')
    prevDate = models.DateField(null=True,db_column='prev_date')
    open = models.FloatField(db_column='open')
    close = models.FloatField(db_column='close')
    low = models.FloatField(db_column='low')
    high = models.FloatField(db_column='high')
    adjClose = models.FloatField(db_column='adjClose')
    volume = models.BigIntegerField(db_column='volume') 
    updatedAt = models.DateField(auto_now_add=True, db_column='updated_at')
    # ema5 = models.FloatField(null=True, db_column='ema5')
    # ema20 = models.FloatField(null=True, db_column='ema20')
    # sma50 = models.FloatField(null=True, db_column='sma50')
      
    
    class Meta:
        db_table = 'trade_data'

    def __int__(self):
        return self.id

class Holidays(models.Model):
    holiday = models.DateTimeField()
    reason = models.CharField(max_length=100)
    
    class Meta:
        db_table = 'holidays'
        
    def __int__(self):
        return self.id
    
class SwingData(models.Model):
    stock = models.ForeignKey(StockNames, on_delete=models.SET_NULL, null=True, db_column = 'stock', related_name='swing_stock_name')
    date = models.DateField(db_column='date')
    startDate = models.DateField(null=True,db_column='start_date')
    endDate = models.DateField(null=True,db_column='end_date') 
    ema5 = models.FloatField(null=True, db_column='ema5')
    ema20 = models.FloatField(null=True, db_column='ema20')
    sma50 = models.FloatField(null=True, db_column='sma50')
    updatedAt = models.DateField(auto_now_add=True, db_column='updated_at')
    close = models.FloatField(null=True, db_column='close')
      
    
    class Meta:
        db_table = 'swing_data'

    def __int__(self):
        return self.id
    