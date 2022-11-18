from django.apps import AppConfig
from django.db.models.signals import post_save


class DjtasksConfig(AppConfig):
    default_auto_field = "django.db.models.BigAutoField"
    name = "djtasks"

    def ready(self):
        from django_celery_results.models import TaskResult
        from djtasks.signals import task_post_save

        post_save.connect(
            task_post_save, sender=TaskResult, dispatch_uid="task_post_save"
        )
