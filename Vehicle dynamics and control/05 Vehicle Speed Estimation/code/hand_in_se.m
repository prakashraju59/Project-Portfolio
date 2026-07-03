%%HAND IN ESTIMATION
load("data.mat")
%% GIVEN DATA
syms M g CoG_f CoG_r frz ffz
para=[M g CoG_f CoG_r];
para_num=[2556,...          %Vehicle mass in Kg
9.81,...                    %gravity in m/s^2
1.47,...                    %Distance CoG to front axle in M
1.51];                      %Distance CoG to rear axle in M
ste_ge_ra=16;               %Steering gear ratio
track_wd=1.65;              %Track width in M
Whl_r=0.36;                 %Nominal wheel radius in M
Cog_h=0.35;                 %Height of CoG relative road

%% 1
C_nx=40; %normalized tyre stiffness
Whl_a=SWA./ste_ge_ra;       %Wheel angle

equ=[frz+ffz==M*g,frz*CoG_r==ffz*CoG_f]; 
sol=subs(solve(equ,[frz ffz]),para,para_num); %front two wheel lumped, so rear

FzFL = double(sol.ffz)/2;
FzFR = double(sol.ffz)/2;
FzRL = double(sol.frz)/2;
FzRR = double(sol.frz)/2;

t_VxwFL = whlSpdFL*Whl_r;
t_VxwFR = whlSpdFR*Whl_r;
t_VxwRL = whlSpdRL*Whl_r;
t_VxwRR = whlSpdRR*Whl_r;

VxwFL = whlSpdFL.*Whl_r.*(1-(TpFL-TbFL)/(Whl_r*C_nx*FzFL));
VxwFR = whlSpdFR.*Whl_r.*(1-(TpFR-TbFR)/(Whl_r*C_nx*FzFR));
VxwRL = whlSpdRL.*Whl_r.*(1-(TpRL-TbRL)/(Whl_r*C_nx*FzRL));
VxwRR = whlSpdRR.*Whl_r.*(1-(TpRR-TbRR)/(Whl_r*C_nx*FzRR));

figure(1)
subplot(1,2,1)
plot(Time,t_VxwFL); hold on; plot(Time,t_VxwFR); hold on
plot(Time,t_VxwRL); hold on; plot(Time,t_VxwRR); hold on
plot(Time,Vx_true); hold off; grid on
xlabel('Time in sec')
ylabel('Wheel hub speed m/s')
legend('tri VxwFL','tri VxwFF','tri VxwRL','tri VxwRR','Vx true')
title('Trivial wheel hub velocity')
subplot(1,2,2)
plot(Time,VxwFL); hold on; plot(Time,VxwFR); hold on
plot(Time,VxwRL); hold on; plot(Time,VxwRR); hold on
plot(Time,Vx_true); hold off; grid on
xlabel('Time in sec')
ylabel('Wheel hub speed m/s')
legend('VxwFL', 'VxwFF','VxwRL','VxwRR','Vx true')
title('wheel hub velocity with tire model')

%% 2
P_VxFL = VxwFL.*cos(Whl_a)+track_wd/2.*wz;
P_VxFR = VxwFR.*cos(Whl_a)-track_wd/2.*wz;
P_VxRL = VxwRL.*cos(0)+track_wd/2.*wz;
P_VxRR = VxwRR.*cos(0)-track_wd/2.*wz;

figure(2)
plot(Time, P_VxFL);hold on;plot(Time, P_VxFR);hold on
plot(Time, P_VxRL);hold on;plot(Time, P_VxRR);hold on
plot(Time,Vx_true);hold off;grid on
xlabel('Time in sec')
ylabel('Speed projected to COG m/s')
legend('P_VxFL','P_VxFF','P_VxRL','P_VxRR','Vx true')
title('Wheel hub speed transformed to COG')

%% 3
P_V_all=[P_VxFL P_VxFR P_VxRL P_VxRR]';
T_v_all=[abs(FzFL./(TpFL-TbFL)) abs(FzFR./(TpFR-TbFR)) ...
    abs(FzFR./(TpRL-TbRL)) abs(FzRR./(TpRR-TbRR))]';
[~,idxs] = max(T_v_all,[],1);

L_i = sub2ind(size(P_V_all),idxs,1:numel(idxs));
Ae_Vx = P_V_all(L_i);
er = Ae_Vx-Vx_true';
RMS_v = num2str(rms(er));

figure(3)
plot(Time,Ae_Vx); hold on; plot(Time,Vx_true); hold off
xlabel('Time in sec')
ylabel('Speed projected to COG m/s')
legend('estimated Vx','Vx true')
title('Wheel hub speed')
grid on
txt = ['RMS:' RMS_v];
text(16.5,18,txt)

%% task 4
