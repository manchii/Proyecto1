## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Script: signal_response.m
## Description: genera y prueba una señal de estímulo para los filtros
##		; esta señal se grafica para cada salida de los filtros,
##		y se compara con la señal de salida con la original. 
##		Además se genera un archivo.txt con los valores binarios
##		para probar en simulador a los filtros en HDL.
## Created: April 2015
## Version: 0.1

T=(0:22.6757:22675.7); %Muestreo a 1/44.1kHz
f1=2.*pi.*(150./100000); %frecuencia a 150Hz
f2=2.*pi.*(1000./100000); %frecuencia a 1kHz
f3=2.*pi.*(10000./100000); %frecuencia a 10kHz

%señal de estímulo de entrada
signal = (sin(f1.*T) + cos(f2.*T) + sin(f3.*T))/3; %Respuesta a una señal

%Generación del vector de estímulos en un archivo .txt
fid= fopen('sin.txt', 'w');

for  i=1:length(signal)
    fprintf (fid, '%s \n', dec2pf(signal(i),14,23,1));
endfor

fclose(fid);


