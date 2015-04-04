## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Script: signal_response.m
## Description: genera y prueba una señal de estímulo para los filtros
##		; esta señal se grafica para cada salida de los filtros,
##		y se compara con la señal de salida con la original. 
##		Además se genera un archivo.txt con los valores binarios
##		para probar en simulador a los filtros en HDL.
## Created: April 2015
## Version: 0.1

T=(0:22.6757:226757); %Muestreo a 1/44.1kHz
f1=2.*pi.*(150./100000); %frecuencia a 150Hz
f2=2.*pi.*(1000./100000); %frecuencia a 1kHz
f3=2.*pi.*(10000./100000); %frecuencia a 10kHz
%Ganancias para los filtros
glow=1;
gmed=1;
ghigh=1;
%señal de estímulo de entrada
signal = sin(f1.*T) + cos(f2.*T) + sin(f3.*T); %Respuesta a una señal

%Filtros
y_LowPass = filtro(filtro(signal,-1.996,0.996,0.998,-1.996,0.998), -1.96,0.9605,199e-6,397.9e-6,199e-6);
y_MedPass = filtro(filtro(signal,-1.96,0.9605,1,-2,1), -1.035,0.3678,0.08316,0.1663,0.08316);
y_HighPass = filtro(filtro(signal,-1.035,0.3678,0.6007,-1.201,0.6007), 1.591,0.6617,0.8132,1.626,0.8132);

%Suma de las señales de salida de los filtros
y= glow*y_LowPass + gmed*y_MedPass + ghigh*y_HighPass;

%Generación de las gráficas
subplot(3,3,1), stem(T(9000:9100),y_LowPass(500:600),'filled')
title('Lowpass filter')
xlabel('Time(us)');
subplot(3,3,2), stem(T(500:600),y_MedPass(500:600),'filled')
title('Mediumpass filter')
xlabel('Time(us)');
subplot(3,3,3), stem(T(500:600),y_HighPass(500:600),'filled')
title('Highpass filter')
xlabel('Time(us)');
subplot(3,3,[4,9]), plot(T(500:600),signal(500:600),'r')
hold on
stem(T(500:600),y(500:600),'filled')
title('input and output signal')
xlabel('Time(us)');


%Generación del vector de estímulos en un archivo .txt
fid= fopen('signal.txt', 'w');

for  i=1:length(signal)
    fprintf (fid, '%s \n', dec2pf(signal(i),14,18,1));
endfor

fclose(fid);


