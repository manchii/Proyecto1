## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: pf2dec 
## Description: La función mapea una cadena de string que describe el
## 		número binario en notación en punto fijo. Esta función
##		puede o no tomar en cuenta el signo,
##It maps from signed or unsigned fixed point number to 
##		decimal from an arbitrary lenght of p and f format.
## Created: April 2015
## Version: 0.1

%% El cálculo para encontrar el valor decimal se realiza de la siguiente 
%% forma: decimal = entero/resolución. El entero representa el traslado 
%% de la cadena de bits a numérico directamente y r el valor más pequeño
%% a describir de tal forma que r=2^(-f).

function NumReal = pf2dec(v,f,s)
	NumReal = 0;
	n=length(v);
	if(s==1) %caso con signo
		integer = bin2dec(v(2:n)) - 2**(str2num(v(1))*(n-1));	
	else	%sin signo
		integer = bin2dec(v);
	endif
	NumReal = integer*2**(-f); %decimal = entero/resolución
endfunction
