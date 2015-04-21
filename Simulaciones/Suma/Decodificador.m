## Author: Kaleb Alfaro Badilla <kaleb.23415@gmail.com>
## Function: Decodificador_sum
## Description: Realiza una comprobación de los valores obtenidos
##		por Modelsim de los módulos de las multiplicaciones
## 		
## Created: April 2015
## Version: 0.1

fid=fopen("output.txt", "r");
while( !feof(fid)) 
	[A,B,Y] = fscanf(fid, "%s\t%s\t%s\n","C");
	[a] = [pf2dec(A,10,1),pf2dec(B,10,1),pf2dec(Y,10,1)];
	disp(a(1)+a(2)),
	disp(a(3));
end
fclose(fid);
 
