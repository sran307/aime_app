# Generated by Django 5.0.1 on 2024-05-12 09:54

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0011_tradedata_enddate_tradedata_startdate'),
    ]

    operations = [
        migrations.AddField(
            model_name='tradedata',
            name='prevDate',
            field=models.DateTimeField(db_column='prev_date', null=True),
        ),
    ]
