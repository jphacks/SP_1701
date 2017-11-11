from rest_framework import routers
from .views import *


router = routers.DefaultRouter()
router.register(r'users/(?P<user_id>[0-9])', UsersViewSet, 'users')
router.register(r'laughs/(?P<user_id>[0-9])/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<day>[0-9]{2})', LaughsViewSet, 'laughs')
router.register(r'laughs/detail/(?P<user_id>[0-9])/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<day>[0-9]{2})', LaughsDetailViewSet, 'laughs-detail')
router.register(r'laugh', LaughViewSet, 'laugh')
router.register(r'sound', SoundViewSet, 'sound')
