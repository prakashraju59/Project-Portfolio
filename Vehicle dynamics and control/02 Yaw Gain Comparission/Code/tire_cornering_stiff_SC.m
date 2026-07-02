%% Tire corning stiffness steady cricle test
v_x =30/3.6; % in m/s
tr_ay =0.9; % in g
Radi = v_x^2/tr_ay ; % in m

%% for tire cornering stiffness data
lumpfy =(FyFR + FyFL);
lumpRy =(FyRR + FyRL);
lumpslipf =(slipAng_FL + slipAng_FR)/2;
lumpslipr =(slipAng_RL + slipAng_RR)/2;

%%to ingnore the starting and ending lets take 20-50sec
%sampled at 1000hz,t_sim is 120sec in carmaker t_start=20000 t_end=50000 ,
%+1 for considering zero indexing
% Cut the signals
t_start = 20000;
t_end   = 50000;
lumpfy_cut    = lumpfy(t_start:t_end);
lumpslipf_cut = lumpslipf(t_start:t_end);

lumpRy_cut    = lumpRy(t_start:t_end);
lumpslipr_cut = lumpslipr(t_start:t_end);

%cornering stiffness
front_cf = lumpfy_cut./lumpslipf_cut;
rear_cr  = lumpRy_cut./lumpslipr_cut;

ctf=rms(front_cf);    %cornering stiffness front 
ctr=rms(rear_cr);    %cornering stiffness rear


figure(1)
plot(lumpslipf , lumpfy);legend('front');grid on
xlabel('Slip angle front in deg')
ylabel('later force Fy front in N')
title('Front cornering stiffness Fy/alpha')
figure(2)
plot(lumpslipf , lumpfy);legend('rear');grid on
xlabel('Slip angle front in deg')
ylabel('later force Fy front in N')
title('Rear cornering stiffness Fy/alpha')
figure(3);
plot(Time,ay);grid on
xlabel('Time in sec')
ylabel('acceleration Ay in m/s^2')
legend('Lateral acceleration')
figure(4);
plot(front_cf); hold on;
plot(rear_cr); hold off;
grid on
title('Cornering stiffness at steady state')
legend('Front','Rear')


