from rest_framework import routers
from .views import *


router = routers.DefaultRouter()
router.register(r'users', UserViewSet, 'users')
router.register(r'post_caf', PostCafViewSet, 'post_caf')
router.register(r'get_weekly_laugh', GetWeeklyLaughViewSet, 'get_weekly_laugh')
