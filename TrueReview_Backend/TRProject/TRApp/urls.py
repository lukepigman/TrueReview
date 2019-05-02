from django.urls import path 
from . import views
# from . import service
urlpatterns = [
    path('', views.index, name='index'),
    # path('get' , service.get, name='get')
]
