function [ y ] = filtro(u,a1,a2,b0,b1,b2)

fNMenos1 = 0;
fNMenos2 = 0;

n = length ( u ) ;
y = zeros(1,n) ;
for i =1:1:n
	f = u( i ) -a1*fNMenos1 -a2*fNMenos2 ;
	y ( i ) = b0* f + b1*fNMenos1 +b2*fNMenos2 ;
	fNMenos2 = fNMenos1 ;
	fNMenos1 = f;
endfor

end
