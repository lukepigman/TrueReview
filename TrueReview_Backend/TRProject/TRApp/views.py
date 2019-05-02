from django.shortcuts import render
from django.http import HttpResponse

def index(request):
    return HttpResponse("TrueReview Project")


# Create your views here.
