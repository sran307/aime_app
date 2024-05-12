
from django.urls import path
# from .views import Usercreate
# from .views import AuthView
from .views import views, stock_views
urlpatterns = [
    # path('login/', views.as_view),
    path('checkExist/', views.checkDeviceExist),
    path('register/', views.registerUser),
    path('login/', views.loginUser),
    path('todo/ins/', views.todoInsert),
    path('todo/list/', views.todoList),
    path('todo/update/', views.todoUpdate),
    path('stock/quotes/', stock_views.getQuotes),
    path('stock/daily/', stock_views.getDailyData),
    path('stock/screen/', stock_views.dataScreen),
    path('stock/holidays/', stock_views.getHolidays)
]
