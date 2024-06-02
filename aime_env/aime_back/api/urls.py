
from django.urls import path
# from .views import Usercreate
# from .views import AuthView
from .views import views, stock_views, stock_ai, trade_analysis
urlpatterns = [
    # path('login/', views.as_view),
    path('checkExist/', views.checkDeviceExist),
    path('register/', views.registerUser),
    path('login/', views.loginUser),
    path('todo/ins/', views.todoInsert),
    path('todo/list/', views.todoList),
    path('todo/update/', views.todoUpdate),
    
    path('stock/codes/', stock_views.getStockCode),
    path('stock/names/', stock_views.getStockName),
    path('stock/quotes/', stock_views.getQuotes),
    path('stock/daily/', stock_views.getDailyData),
    path('stock/screen/', stock_views.dataScreen),
    path('stock/holidays/', stock_views.getHolidays),
    # path('stock/predict/', stock_ai.getPredictPrice),
    
    path('stock/fundas/', stock_views.GetFundas),
    path('stock/slug/', stock_views.GetSlug),
    path('stock/penny/', stock_views.GetPenny),
    path('stock/sector/', stock_views.getSector),

    path('trendy/sector/', trade_analysis.getTrendySector),
    path('swing/analys/', trade_analysis.swingAnalysis),
]
