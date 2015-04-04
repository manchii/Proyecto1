## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: filtro
## Description: Esta función recibe un vector 'u' el cual representa
##		la señal muestreada n veces a un tiempo de muestreo 
##		1/44.1kHz. 'y' representa la señal de salida.
## Created: April 2015
## Version: 0.1

function [ y ] = filtro(u,a1,a2,b0,b1,b2)

fNMenos1 = 0;
fNMenos2 = 0;

n = length (u);
y = zeros(1,n);

##Función de transferencia de la forma:
#		b0z^2 + b1z + b2
#H(z)	=	----------------
#		 z^2 + a1z + a2

for i =1:1:n
	f = u(i) -a1*fNMenos1 -a2*fNMenos2;
	y (i) = b0* f + b1*fNMenos1 +b2*fNMenos2 ;
	fNMenos2 = fNMenos1;
	fNMenos1 = f;
endfor

end
