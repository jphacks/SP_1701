from datetime import datetime
from django.db import models
import string
import random


def gen_rand_str():
    length = 10
    chars = string.digits + string.ascii_letters
    return ''.join([random.choice(chars) for _ in range(length)])


class User(models.Model):
    random_id = models.CharField(max_length=10, default=gen_rand_str, unique=True, blank=False)
    available_smileage = models.IntegerField(default=0)
    used_smileage = models.IntegerField(default=0)
    is_active = models.BooleanField(default=False)

    def __str__(self):
        return self.random_id


class Laugh(models.Model):
    user = models.ForeignKey(User)
    created_at = models.DateTimeField(default=datetime.now)

    def __str__(self):
        return self.user.random_id
