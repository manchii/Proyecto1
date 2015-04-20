## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: dec2pf 
## Description: La función mapea una variable en notación decimal y es
##		trasladada en el dominio binario en notación punto fijo
##		con f decimales, n bits y con la posibilidad de incluir
##		signo o no.
## Created: April 2015
## Version: 0.1


%% Se utiliza la aproximación donde se encontra la resolución 
%% 'r'=2^(-f) y el valor entero más próximo a dec/r. Esto porque
%% se puede definir que la cadena de bits representa el número binario
%% tal que integer*r=dec ; por lo tanto se puede buscar que 
%% integer = dec/r. Posteriormente se realiza el caso del signo.

function stroutput = dec2pf(dec,f,n,s)
	stroutput = '0';
	integer = round(dec/(2**(-f))); %cálculo del entero
	if(s==0)			%caso de sin signo
		stroutput = dec2bin(integer,n);
	else				%caso con signo
		if(integer<0)		%si el entero es negativo
		%Se realiza la cadena de bits con el complemento a 2
			stroutput = strcat('1',dec2bin((integer+2**(n-1)),(n-1)));
		else
		%Caso si el entero es positivo
			stroutput = strcat('0',dec2bin(integer,(n-1)));
		endif
	endif
endfunction
