# Generated by Django 5.0.1 on 2024-09-19 14:53

import django.db.models.deletion
import uuid
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0035_goals'),
    ]

    operations = [
        migrations.CreateModel(
            name='assets',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('guid', models.UUIDField(default=uuid.uuid4, editable=False, unique=True)),
                ('asset_name', models.CharField(max_length=100, null=True)),
                ('asset_amnt', models.FloatField(null=True)),
                ('purchased_on', models.DateTimeField()),
                ('valid_on', models.DateTimeField(null=True)),
                ('insertAt', models.ForeignKey(db_column='insert_at', null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='asset_inserts', to='api.metadata')),
                ('updateAt', models.ForeignKey(db_column='update_at', null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='asset_updates', to='api.metadata')),
                ('user', models.ForeignKey(db_column='user_id', on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
            options={
                'db_table': 'assets',
            },
        ),
    ]
