%qcm paramters

Ms=1800; %in Kg
Mus=200; %in Kg
Cs=77*10^3; %in N/m
Ds=9*10^3; %in Ns/m;
%Ds=0; %in Ns/m;
Ct=774*10^3; %in N/m

alpha = 0.4;
ds_ext = 1.5 * 9e3;
ds_com = 0.5 * 9e3;
ds_eq = alpha * ds_ext + (1 - alpha) * ds_com;
%state sapce
A=[0 0 1 0;0 0 0 1;-Cs/Ms Cs/Ms -Ds/Ms Ds/Ms;Cs/Mus (-Cs-Ct)/Ms Ds/Ms -Ds/Ms];
A2=[0 0 1 0;0 0 0 1;   
   -Cs/Ms Cs/Ms -ds_eq/Ms ds_eq/Ms;
   Cs/Mus (-Ct-Cs)/Ms ds_eq/Ms -ds_eq/Ms];
B=[0;0;0;Ct/Mus];
C=[1 0 0 0]; %for Zu/ddot
D=0;
sysQCM=ss(A,B,C,D);
sysQCM2=ss(A2,B,C,D);

%% stability check
eigs_A = eig(A);
disp('Eigenvalues of A:');
disp(eigs_A);
if all(real(eigs_A) < 0)
    disp('System is stable (all eigenvalues have negative real parts).');
else
    disp('System is unstable.');
end

poles=pole(sysQCM);
tranferfunction=tf(sysQCM);
poles2=pole(sysQCM2); 
tranferfunction2=tf(sysQCM2);
%% response
[y,tout]=step(tranferfunction,0:0.01:25);
[y2,tout2]=step(tranferfunction2,0:0.01:50);
figure(1)
plot(tout,y), %hold on
%plot(tout2,y2), hold off
xlabel('time'),ylabel('amplitude')
legend('Zr-Zs')
grid on
figure(2);
bode(sysQCM);%hold on
%bode(sysQCM2);hold on
grid on;
title('Bode Diagram: Road input z_r to Sprung Mass Position z_s');
