from djtasks.models import Counter


def task_post_save(sender, instance, created, **kwargs):
    if created:
        counter = Counter.objects.get(task_id=instance.task_id)
        counter.result = instance
        counter.save(update_fields=["result"])
