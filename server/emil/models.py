from django.db import models
import string
import random


def gen_rand_str():
    length = 10
    chars = string.digits + string.ascii_letters
    return ''.join([random.choice(chars) for _ in range(length)])


class User(models.Model):
    random_id = models.CharField(max_length=10, default=gen_rand_str, unique=True, blank=False)
    smileage = models.IntegerField(default=0)


class Laughs(models.Model):
    user = models.ForeignKey(User)
    created_at = models.DateTimeField(auto_now_add=True)
