
from django.urls import path
# from .views import Usercreate
# from .views import AuthView
from . import views
urlpatterns = [
    # path('login/', views.as_view),
    path('checkExist/', views.checkDeviceExist),
    path('register/', views.registerUser),
    path('login/', views.loginUser),
    path('todo/ins/', views.todoInsert),
    path('todo/list/', views.todoList),
    path('todo/update/', views.todoUpdate)
]
