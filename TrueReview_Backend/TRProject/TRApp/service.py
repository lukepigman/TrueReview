from django.http import HttpResponse
from django.http import JsonResponse
import json
import TRApp.utils.request as req
def get(request):
    id = request.GET.get('id', '')
    return execute(id)

def execute(id):
    jsonderulo = req.process(id)
    return HttpResponse(json.dumps(jsonderulo), content_type="application/json")