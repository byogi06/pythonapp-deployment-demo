from django.shortcuts import render
from django.http import JsonResponse

# Create your views here.
def home(request,*args,**kwargs):
    return JsonResponse({"message":"Hi Allianz, I am Yogesh Bhagat"})