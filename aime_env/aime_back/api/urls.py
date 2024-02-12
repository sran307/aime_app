
from django.urls import path
from .views import Usercreate

urlpatterns = [
    path('login/', Usercreate.as_view()),
]
