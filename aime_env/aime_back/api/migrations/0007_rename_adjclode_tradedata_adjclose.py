# Generated by Django 5.0.1 on 2024-05-05 12:11

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_tradedata'),
    ]

    operations = [
        migrations.RenameField(
            model_name='tradedata',
            old_name='adjClode',
            new_name='adjClose',
        ),
    ]
