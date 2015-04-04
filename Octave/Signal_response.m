## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Script:  
## Description: It maps from signed decimal number to signed fixed point
##		from an arbitrary lenght of p and f format.
## Created: April 2015
## Version: 0.1

T=(0:22.6757:226757);
f1=2.*pi.*(150./100000);
f2=2.*pi.*(1000./100000);
f3=2.*pi.*(10000./100000);
glow=1;
gmed=1;
ghigh=1;
signal = sin(f1.*T) + cos(f2.*T) + sin(f3.*T); %Respuesta a una señal

y_LowPass = filtro(filtro(signal,-1.996,0.996,0.998,-1.996,0.998), -1.96,0.9605,199e-6,397.9e-6,199e-6);
y_MedPass = filtro(filtro(signal,-1.96,0.9605,1,-2,1), -1.035,0.3678,0.08316,0.1663,0.08316);
y_HighPass = filtro(filtro(signal,-1.035,0.3678,0.6007,-1.201,0.6007), 1.591,0.6617,0.8132,1.626,0.8132);

y= glow*y_LowPass + gmed*y_MedPass + ghigh*y_HighPass;

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


fid= fopen('signal.txt', 'w');

for  i=1:length(signal)
    fprintf (fid, '%s \n', dec2pf(signal(i),14,18,1));
endfor

fclose(fid);


