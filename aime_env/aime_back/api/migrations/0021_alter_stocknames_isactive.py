# Generated by Django 5.0.1 on 2024-05-19 11:50

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0020_stockcodes'),
    ]

    operations = [
        migrations.AlterField(
            model_name='stocknames',
            name='isActive',
            field=models.BooleanField(db_column='is_active', default=False),
        ),
    ]
