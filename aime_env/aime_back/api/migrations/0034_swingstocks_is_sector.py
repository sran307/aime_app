# Generated by Django 5.0.1 on 2024-06-17 06:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0033_longstocks_away_from_longstocks_five_yr_roe_and_more'),
    ]

    operations = [
        migrations.AddField(
            model_name='swingstocks',
            name='is_sector',
            field=models.BooleanField(default=False),
        ),
    ]