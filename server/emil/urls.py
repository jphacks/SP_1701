from rest_framework import routers
from .views import *


router = routers.DefaultRouter()
router.register(r'users/(?P<id>[0-9])', UsersViewSet, 'users')
# router.register(r'post_caf', PostCafViewSet, 'post_caf')
router.register(r'laughs', LaughsViewSet, 'laughs')
router.register(r'get_timetable_laugh', GetTimetableLaughViewSet, 'get_timetable_laugh')
router.register(r'save_laugh', SaveLaughViewSet, 'save_laugh')