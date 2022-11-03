from celery import shared_task
from djtasks.models import Counter


@shared_task
def increment_counter(counter_id):
    counter = Counter.objects.get(id=counter_id)
    counter.count += 1
    counter.save()
