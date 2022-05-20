from rest_framework.decorators import api_view
from rest_framework.response import Response

from blog.models import Article


@api_view(["GET"])
def article_count(request):
    count = Article.objects.count()

    return Response(
        {
            "count": count,
        }
    )
