from django.conf import settings
from django.db import models
from django_celery_results.models import TaskResult


class Counter(models.Model):
    task_id = models.CharField(
        max_length=getattr(settings, "DJANGO_CELERY_RESULTS_TASK_ID_MAX_LENGTH", 255),
        unique=True,
        verbose_name="Task ID",
        help_text="Celery ID for the Task that was run",
        null=True,
        blank=True,
    )
    result = models.OneToOneField(
        TaskResult, on_delete=models.CASCADE, null=True, blank=True
    )
    count = models.fields.IntegerField(default=0)

    def __str__(self) -> str:
        result = TaskResult.objects.filter(task_id=self.task_id).first()
        return "ID {} counted {} | {}".format(
            self.pk, self.count, result.status if result else "Unknown"
        )
