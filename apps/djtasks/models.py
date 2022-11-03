from django.db import models


class Counter(models.Model):
    count = models.fields.IntegerField(default=0)

    def __str__(self) -> str:
        return "ID {} counted {}".format(self.pk, self.count)
