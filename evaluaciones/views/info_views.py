from django.shortcuts import render

def index(request):
    return render(request, 'evaluaciones/index.html')

def nosotros(request):
    return render(request, 'evaluaciones/nosotros.html')

def servicios(request):
    return render(request, 'evaluaciones/servicios.html')

def contacto(request):
    return render(request, 'evaluaciones/contacto.html')

def comenzar(request):
    return render(request, 'evaluaciones/comenzar.html')