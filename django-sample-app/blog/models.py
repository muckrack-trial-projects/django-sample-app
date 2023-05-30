from django.db import models


class Article(models.Model):
    title = models.CharField(max_length=240)
    content = models.TextField(default='')
    is_published = models.BooleanField(default=False)

    def __str__(self):
        return self.title
