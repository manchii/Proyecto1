## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: Decodificador_mult
## Description: Realiza una comprobación de los valores obtenidos
##		por Modelsim de los módulos de filtros
## 		
## Created: April 2015
## Version: 0.1
T=(0:22.6757:2267.57);%Muestreo a 1/44.1kHz

uk=16*T/1e6;

%señal de estímulo de entrada

%yk_bass = zeros(1,201);
%yk_med = zeros(1,201);
%yk_high = zeros(1,201);

yk = zeros(1,101);
i = 1;
fid=fopen("output_dac.txt", "r");

while( !feof(fid)) 
	Output = fscanf(fid, "%s\n","C");
	yk(i) = pf2dec(Output,12,0)-.5;
	i = i + 1;
end
fclose(fid);


%Filtros
y_LowPass = filtro(filtro(uk,-1.996,0.996,0.998,-1.996,0.998), -1.96,0.9605,199e-6,397.9e-6,199e-6);
%y_MedPass = filtro(filtro(uk,-1.96,0.9605,1,-2,1), -1.035,0.3678,0.08316,0.1663,0.08316);
%y_HighPass = filtro(filtro(uk,-1.035,0.3678,0.6007,-1.201,0.6007), 1.591,0.6617,0.8132,1.626,0.8132);

%subplot(3,1,1),
%plot(	T,uk,'LineWidth',2,
%	T,y_LowPass,'--','LineWidth',3,
%	T,yk_bass,'LineWidth',2);

%subplot(3,1,2),
%plot(	T,uk,'LineWidth',2,
%	T,y_MedPass,'--','LineWidth',3,
%	T,yk_med,'LineWidth',2);

%subplot(3,1,3),
%plot(	T,uk,'LineWidth',2,
%	T,y_HighPass,'--','LineWidth',3,
%	T,yk_high,'LineWidth',2);

plot(T,yk,'LineWidth',2,T,uk,'LineWidth',2,T,y_LowPass,'LineWidth',2);


