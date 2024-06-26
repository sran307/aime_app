# Generated by Django 5.0.1 on 2024-06-02 16:34

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0029_swingstocks_tot_rank'),
    ]

    operations = [
        migrations.CreateModel(
            name='TrendySector',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('sector', models.CharField(max_length=50, null=True)),
                ('no', models.IntegerField(null=True)),
                ('week', models.FloatField(null=True)),
                ('month', models.FloatField(null=True)),
                ('perc', models.FloatField(null=True)),
            ],
            options={
                'db_table': 'trendy_sector',
            },
        ),
    ]
