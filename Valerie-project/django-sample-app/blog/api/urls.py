from django.urls import path

from . import views


urlpatterns = [
    path("count", views.article_count, name="article-count"),
]
