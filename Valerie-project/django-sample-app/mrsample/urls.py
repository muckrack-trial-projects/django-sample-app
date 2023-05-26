from django.contrib import admin
from django.urls import path, include

from blog.api import urls as blog_api_urls


urlpatterns = [
    path("admin/", admin.site.urls),
    path("api/articles/", include(blog_api_urls)),
    path("ht/", include('health_check.urls')),
]
