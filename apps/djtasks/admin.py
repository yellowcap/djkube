from celery import uuid
from django.contrib import admin
from djtasks.models import Counter
from djtasks.tasks import increment_counter


class CounterModelAdmin(admin.ModelAdmin):
    actions = [
        "increment_counter_action",
    ]

    def increment_counter_action(self, request, queryset):
        for counter in queryset.all():
            counter.task_id = uuid()
            counter.save(update_fields=["task_id"])
            increment_counter.apply_async((counter.id,), task_id=counter.task_id)

        self.message_user(
            request, "Started increment for {} counters.".format(queryset.count())
        )


admin.site.register(Counter, CounterModelAdmin)
