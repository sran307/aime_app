# Generated by Django 5.0.1 on 2024-05-26 10:03

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0022_stocknames_stockslug_stockratios'),
    ]

    operations = [
        migrations.AlterModelTable(
            name='stockratios',
            table='stock_ratios',
        ),
    ]
