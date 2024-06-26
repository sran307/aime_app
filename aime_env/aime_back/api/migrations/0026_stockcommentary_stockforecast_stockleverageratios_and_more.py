# Generated by Django 5.0.1 on 2024-05-28 15:58

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0025_stockholdings'),
    ]

    operations = [
        migrations.CreateModel(
            name='StockCommentary',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('item', models.CharField(max_length=100, null=True)),
                ('itemType', models.CharField(max_length=100, null=True)),
                ('mood', models.CharField(max_length=100, null=True)),
                ('title', models.CharField(max_length=100, null=True)),
                ('message', models.TextField(null=True)),
                ('description', models.TextField(null=True)),
                ('tag', models.CharField(max_length=100, null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='cmnt_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_commentary',
            },
        ),
        migrations.CreateModel(
            name='StockForecast',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('total', models.FloatField(null=True)),
                ('buy', models.FloatField(null=True)),
                ('sell', models.FloatField(null=True)),
                ('nuet', models.FloatField(null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='forecast_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_forecast',
            },
        ),
        migrations.CreateModel(
            name='StockLeverageRatios',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('intCover', models.FloatField(blank=True, null=True)),
                ('debtEq', models.FloatField(blank=True, null=True)),
                ('debtAs', models.FloatField(blank=True, null=True)),
                ('finLe', models.FloatField(blank=True, null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='lvr_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_leverage_ratios',
            },
        ),
        migrations.CreateModel(
            name='StockOperatingRatios',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('fxtr', models.FloatField(blank=True, null=True)),
                ('wctr', models.FloatField(blank=True, null=True)),
                ('tatr', models.FloatField(blank=True, null=True)),
                ('rtr', models.FloatField(blank=True, null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='oprt_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_operating_ratios',
            },
        ),
        migrations.CreateModel(
            name='StockProfitRatios',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('pat', models.FloatField(blank=True, null=True)),
                ('ebita', models.FloatField(blank=True, null=True)),
                ('ebitam', models.FloatField(blank=True, null=True)),
                ('roe', models.FloatField(blank=True, null=True)),
                ('roce', models.FloatField(blank=True, null=True)),
                ('roa', models.FloatField(blank=True, null=True)),
                ('eps', models.FloatField(blank=True, null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='profit_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_profit_ratios',
            },
        ),
        migrations.CreateModel(
            name='StockValuationRatios',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('pe', models.FloatField(blank=True, null=True)),
                ('pbv', models.FloatField(blank=True, null=True)),
                ('ps', models.FloatField(blank=True, null=True)),
                ('stock', models.ForeignKey(db_column='stock', null=True, on_delete=django.db.models.deletion.CASCADE, related_name='vlt_stock_name', to='api.stocknames')),
            ],
            options={
                'db_table': 'stock_valuation_ratios',
            },
        ),
    ]
