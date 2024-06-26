# Generated by Django 5.0.1 on 2024-05-18 15:43

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0017_swingdata_close'),
    ]

    operations = [
        migrations.AddField(
            model_name='stocknames',
            name='industry',
            field=models.CharField(db_column='industry', max_length=150, null=True),
        ),
        migrations.AddField(
            model_name='stocknames',
            name='isFno',
            field=models.BooleanField(db_column='is_fno', default=False),
        ),
        migrations.AddField(
            model_name='stocknames',
            name='sector',
            field=models.CharField(db_column='sector', max_length=150, null=True),
        ),
    ]
