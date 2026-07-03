run('Vehicle_parameters.m')
load('steady_circle.mat')

%% state space comparision

v_x=mean(vx);         %in m/s
Ts=double(mean(diff(Time))); %sample rate
A=[-(ctf+ctr)/(m*v_x) ((-ctf*lf+ctr*lr)/(m*v_x))-v_x;...
(-(ctf*lf-ctr*lr)/(Jz*v_x)) -(ctf*lf^2+ctr*lr^2)/(Jz*v_x)];
B=[ctf/m; ctf*lf/Jz];
C=[0 1];
D=0;
G=ss(A,B,C,D);
data=iddata(yawRate,(SteerAng_FL+SteerAng_FR)./2,Ts);%from carmaker
np=2;
sys=tfest(data,np,1);
figure()
opts=bodeoptions('cstprefs');
opts.FreqUnits='Hz';
opts.Grid='on';
bodemag(G);hold on;
bodemag(sys,opts);hold off;
legend('anallitical','carmaker')
grid on

