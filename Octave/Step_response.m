T=(0:22.6757:226757);

Step=ones(1,length(T));

y_LowPass = filtro(filtro(Step,-1.996,0.996,0.998,-1.996,0.998), -1.96,0.9605,199e-6,397.9e-6,199e-6);
y_MedPass = filtro(filtro(Step,-1.96,0.9605,1,-2,1), -1.035,0.3678,0.08316,0.1663,0.08316);
y_HighPass = filtro(filtro(Step,-1.035,0.3678,0.6007,-1.201,0.6007), 1.591,0.6617,0.8132,1.626,0.8132);

 
subplot(3,1,1), plot(T(1:500),y_LowPass(1:500));
subplot(3,1,2), plot(T(1:500),y_MedPass(1:500));
subplot(3,1,3), plot(T(1:500),y_HighPass(1:500));


fid= fopen('Step.txt', 'w');

for  i=1:length(signal)
    fprintf (fid, '%s \n', dec2pf(Step(i),14,18,1));
endfor

fclose(fid);
