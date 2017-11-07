from rest_framework import routers
from .views import *


router = routers.DefaultRouter()
router.register(r'users/(?P<user_id>[0-9])', UsersViewSet, 'users')
# router.register(r'post_caf', PostCafViewSet, 'post_caf')
router.register(r'laughs/(?P<user_id>[0-9])/(?P<year>[0-9]{4})/(?P<month>[0-9]{2})/(?P<day>[0-9]{2})', LaughsViewSet, 'laughs')
router.register(r'get_timetable_laugh', GetTimetableLaughViewSet, 'get_timetable_laugh')
router.register(r'save_laugh', SaveLaughViewSet, 'save_laugh')