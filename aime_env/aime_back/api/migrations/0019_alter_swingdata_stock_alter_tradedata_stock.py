# Generated by Django 5.0.1 on 2024-05-19 05:18

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0018_stocknames_industry_stocknames_isfno_and_more'),
    ]

    operations = [
        migrations.AlterField(
            model_name='swingdata',
            name='stock',
            field=models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='swing_stock_name', to='api.stocknames'),
        ),
        migrations.AlterField(
            model_name='tradedata',
            name='stock',
            field=models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='stock_name', to='api.stocknames'),
        ),
    ]