# Generated by Django 4.1.3 on 2022-11-18 10:02

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ("django_celery_results", "0011_taskresult_periodic_task_name"),
    ]

    operations = [
        migrations.CreateModel(
            name="Counter",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "task_id",
                    models.CharField(
                        blank=True,
                        help_text="Celery ID for the Task that was run",
                        max_length=255,
                        null=True,
                        unique=True,
                        verbose_name="Task ID",
                    ),
                ),
                ("count", models.IntegerField(default=0)),
                (
                    "result",
                    models.OneToOneField(
                        blank=True,
                        null=True,
                        on_delete=django.db.models.deletion.CASCADE,
                        to="django_celery_results.taskresult",
                    ),
                ),
            ],
        ),
    ]
