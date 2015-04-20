## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Script: signal_adc_sim.m
## Description: genera y prueba una señal de estímulo para el receptor 	
##		del adc.
##		Además se genera un archivo.txt con los valores binarios
##		para probar en simulador a los filtros en HDL.
## Created: April 2015
## Version: 0.1

T=(0:22.6757:2267.57); %Muestreo a 1/44.1kHz
f1=2.*pi.*(150./100000); %frecuencia a 150Hz
f2=2.*pi.*(1000./100000); %frecuencia a 1kHz
f3=2.*pi.*(10000./100000); %frecuencia a 10kHz

%señal de estímulo de entrada
signal = (sin(f1.*T) + cos(f2.*T) + sin(f3.*T))/3; %Respuesta a una señal
signal = signal + 1; %offset

%guardar en .txt
fid= fopen('signal.txt', 'w');

for  i=1:length(signal)
    fprintf (fid, '%s \n', dec2pf(signal(i),10,12,0)); %12bits largo
endfor

fclose(fid);

