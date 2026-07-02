%%velocityprofiletomimickcruise
%%test on striaght road
t_r_up=10;
t_c_40=20;
t_st_60=50;
t_st_120=40;
t_st_40=40;
v_r_up=linspace(0,40/3.6,t_r_up);
v_c_40=ones(1,t_c_40)*40/3.6;
v_st_60=ones(1,t_st_60)*60/3.6;
v_st_120=ones(1,t_st_120)*120/3.6;
v_st_40=ones(1,t_st_40)*40/3.6;

t_all=t_r_up+t_c_40+t_st_60+t_st_120+t_st_40;
v_all=[v_r_up v_c_40 v_st_60 v_st_120 v_st_40];
t=linspace(0,t_all,t_all);
profile_data=timeseries(v_all,t);
%%
figure(1)
plot(profile_data);hold on;grid on
plot(Time,vx);legend('speeed profile','car vx')
ylabel('velocity in m/s');xlabel('time in sec')
%%
figure(2)
plot(ay);hold on;grid on
yline(-2);yline(2);legend('Ay in m/s^2','limit')
ylabel('lateral acc in m/s^2');xlabel('time in sec')
title('Later acceleration limit')