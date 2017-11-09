from datetime import timedelta

from django.core.management.base import BaseCommand
from ...models import *


class Command(BaseCommand):
    help = 'Create Laugh Dummy Data'

    def add_arguments(self, parser):
        parser.add_argument(
            '--test',
            action='store_true',
            dest='test',
            default=False,
            help='Do not save dummy data',
        )

    def handle(self, *args, **options):

        user = User.objects.get(random_id='KQsRm2J6sj')

        for day in range(1, 32):

            # 1日に笑う総数
            one_day_laugh_count = random.randint(400, 800)

            for _ in range(one_day_laugh_count):
                hour = random.randint(6, 23)
                miniute = random.randint(0, 59)

                laugh_datetime = datetime(2017, 10, day, hour, miniute, miniute)
                print(laugh_datetime)
                print(laugh_datetime+timedelta(hours=9))

                if not options['test']:
                    Laugh.objects.create(user=user, created_at=laugh_datetime+timedelta(hours=9))
