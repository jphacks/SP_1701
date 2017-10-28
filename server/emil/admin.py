from django.contrib import admin
from .models import *


class UserAdmin(admin.ModelAdmin):
    list_display = ('random_id', 'available_smileage', 'used_smileage', 'is_active')


class LaughAdmin(admin.ModelAdmin):
    list_display = ('user', 'created_at')


admin.site.register(User, UserAdmin)
admin.site.register(Laugh, LaughAdmin)
