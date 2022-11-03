from django.contrib import admin
from djtasks.models import Counter
from djtasks.tasks import increment_counter


class CounterModelAdmin(admin.ModelAdmin):
    actions = [
        "increment_counter",
    ]

    def increment_counter(self, request, queryset):
        for counter in queryset.all():
            increment_counter.delay(counter.id)

        self.message_user(
            request, "Started increment for {} counters.".format(queryset.count())
        )


admin.site.register(Counter, CounterModelAdmin)
