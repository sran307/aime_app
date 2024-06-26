# Generated by Django 5.0.1 on 2024-05-19 10:47

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0019_alter_swingdata_stock_alter_tradedata_stock'),
    ]

    operations = [
        migrations.CreateModel(
            name='StockCodes',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('stockCode', models.CharField(db_column='stock_code', max_length=50)),
                ('isUsed', models.BooleanField(db_column='is_used', default=False)),
            ],
            options={
                'db_table': 'stock_codes',
            },
        ),
    ]
