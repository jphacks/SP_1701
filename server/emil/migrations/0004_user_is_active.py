# -*- coding: utf-8 -*-
# Generated by Django 1.11.6 on 2017-10-28 07:56
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('emil', '0003_auto_20171028_0738'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='is_active',
            field=models.BooleanField(default=False),
        ),
    ]