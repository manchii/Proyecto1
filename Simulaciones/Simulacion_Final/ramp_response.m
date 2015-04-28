## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Script: rampa_response.m
## Description: genera una señal de estímulo de rampa para los filtros
##		; esta señal se grafica para cada salida de los filtros,
##		y se compara con la señal de salida con la original. 
##		Además se genera un archivo.txt con los valores binarios
##		para probar en simulador a los filtros en HDL.
## Created: April 2015
## Version: 0.1


Nbits = 23;
fraccion = 14;


T=(0:22.6757:22675.7);%Muestreo a 1/44.1kHz

Ramp=4*T/1e6;

%Generación del vector de estímulos en un archivo .txt
fid= fopen('ramp.txt', 'w');

for  i=1:length(Ramp)
    fprintf (fid, '%s \n', dec2pf(Ramp(i),fraccion,Nbits,1));
endfor

fclose(fid);

