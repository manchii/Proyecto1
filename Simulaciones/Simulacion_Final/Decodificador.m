## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: Decodificador_mult
## Description: Realiza una comprobación de los valores obtenidos
##		por Modelsim de los módulos de filtros
## 		
## Created: April 2015
## Version: 0.1
T=(0:22.6757:22675.7);%Muestreo a 1/44.1kHz
#uk = 4*T/1e6;
f1=2.*pi.*(150./100000); %frecuencia a 150Hz
f2=2.*pi.*(1000./100000); %frecuencia a 1kHz
f3=2.*pi.*(10000./100000); %frecuencia a 10kHz

%señal de estímulo de entrada
uk = (sin(f1.*T) + cos(f2.*T) + sin(f3.*T))/3; %Respuesta a una señal

yk_bass = zeros(1,201);
yk_med = zeros(1,201);
yk_high = zeros(1,201);
i = 1;
fid=fopen("output_bass.txt", "r");

while( !feof(fid)) 
	Output = fscanf(fid, "%s\n","C");
	yk_bass(i) = pf2dec(Output,14,1);
	i = i + 1;
end
fclose(fid);

i = 1;
fid=fopen("output_med.txt", "r");
while( !feof(fid)) 
	Output = fscanf(fid, "%s\n","C");
	yk_med(i) = pf2dec(Output,14,1);
	i = i + 1;
end
fclose(fid);

i = 1;
fid=fopen("output_high.txt", "r");
while( !feof(fid)) 
	Output = fscanf(fid, "%s\n","C");
	yk_high(i) = pf2dec(Output,14,1);
	i = i + 1;
end
fclose(fid);

%Filtros
y_LowPass = filtro(filtro(uk,-1.996,0.996,0.998,-1.996,0.998), -1.96,0.9605,199e-6,397.9e-6,199e-6);
y_MedPass = filtro(filtro(uk,-1.96,0.9605,1,-2,1), -1.035,0.3678,0.08316,0.1663,0.08316);
y_HighPass = filtro(filtro(uk,-1.035,0.3678,0.6007,-1.201,0.6007), 1.591,0.6617,0.8132,1.626,0.8132);

subplot(2,1,1),
plot(#	T,uk,'LineWidth',2,
	T,y_LowPass,'--','LineWidth',2,
	T,yk_bass,'LineWidth',2);

subplot(2,1,2),
plot(#	T,uk,'LineWidth',2,
	T,y_MedPass,'--','LineWidth',2,
	T,yk_med,'LineWidth',2);

#subplot(3,1,3),
#plot(#	T,uk,'LineWidth',2,
#	T,y_HighPass,'--','LineWidth',2,
#	T,yk_high,'LineWidth',2);

