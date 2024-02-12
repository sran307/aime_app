
from django.urls import path
from .views import Usercreate

urlpatterns = [
    path('', Usercreate.as_view()),
]
