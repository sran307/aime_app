# Generated by Django 5.0.1 on 2024-04-21 15:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0003_todo_isregular'),
    ]

    operations = [
        migrations.AlterField(
            model_name='todo',
            name='todoDate',
            field=models.DateTimeField(db_column='todo_date'),
        ),
    ]
