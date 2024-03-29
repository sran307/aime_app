# Generated by Django 5.0.1 on 2024-03-10 05:06

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='deviceDetails',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('deviceName', models.CharField(max_length=15)),
                ('deviceId', models.CharField(max_length=255)),
                ('registeredAt', models.DateTimeField(auto_now_add=True)),
                ('lastLoginAt', models.DateTimeField()),
                ('userId', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'device_details',
                'unique_together': {('deviceName', 'deviceId')},
            },
        ),
    ]
