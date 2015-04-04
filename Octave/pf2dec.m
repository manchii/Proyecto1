## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: pf2dec 
## Description: It maps from signed or unsigned fixed point number to 
##		decimal from an arbitrary lenght of p and f format.
## Created: April 2015
## Version: 0.1

function NumReal = pf2dec(v,f,s)
	NumReal = 0;
#	if(nargin!=4)
#		print_usage();
#	endif
	
#	if(! iscellstr(v))
#		error("pf2dec: v must be a string or cellstring");
#	endif
	n=length(v);
	if(s==1)
		integer = bin2dec(v(2:n)) - 2**(str2num(v(1))*(n-1));	
	else
		integer = bin2dec(v);
	endif
	NumReal = integer*2**(-f);
endfunction
