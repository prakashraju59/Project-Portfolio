%%
run('Vehicle_parameters.m')

%% Normal force estimation
equ_mz =( FxFR + FxRR - FxFL - FxRL )*(1.672/2);

equ12 = m*(h*cf*(lf+lr) - h_rcf*(cf*lf - cr*lr))/(wf*(lf + lr)*(cf + cr));

F1z = lr*m*g/(2*(lf + lr)) - ax.*m*h/(2*(lf + lr)) -ay.* equ12 + rollAcc.*cf*Jx/(wf*(cf + cr))- ...
        yawAcc.*h_rcf*Jz/(wf*(lf + lr)) + equ_mz.*h_rcf/(wf*(lf + lr));

F2z = lr *m*g/(2*(lf + lr)) -ax.*m*h/(2*(lf + lr)) +ay.*equ12 - rollAcc.*cf*Jx/(wf*(cf+cr))+...
        yawAcc.*h_rcf*Jz/(wf*(lf + lr))- equ_mz.*h_rcf/(wf*(lf + lr));

equ34 = m*(h*cf*(lf + lr) + h_rcr*(cf*lf - cr*lr))/(wr*(lf + lr)*(cf + cr));

F3z = lf*m*g/(2*(lf + lr)) +ax.*m*h/(2*(lf + lr)) -ay.* equ34 + ...
rollAcc.*cr*Jx/(wr*(cf + cr))+ yawAcc.*h_rcr*Jz/(wr*(lf + lr))- equ_mz.*h_rcr/(wf *(lf + lr));

F4z = lf *m*g/(2*(lf + lr)) +ax.*m*h/(2*(lf + lr)) +ay.* equ34 - ...
rollAcc.*cr*Jx/(wr*(cf + cr)) - yawAcc.*h_rcr*Jz/(wr *(lf + lr))+ equ_mz.*h_rcr/(wf*(lf + lr));

front_z_s = (lr* m*g /(2*( lf + lr )))*(2/3);   %lumped and then divided
rear_z_s = (lf*m*g /(2*( lf + lr )))*(2/3);     %lumped and then divided

figure (1)
plot ( Time , FzFL ); hold on ; plot ( Time , FzFR ); hold on
plot ( Time , F1z ,'--'); hold on ; plot ( Time , F2z ,'--')
xlabel ('time (s)')
ylabel ('Normal force (N)')
title ('Front Wheel Normal Forces ')
grid on
legend ('Actual Left Wheel NF ',' Actualright Wheel NF ' ,...
'Estimated Left Wheel NF ','Estimated Right Wheel NF ')
%ylim ([ -1000 16000])
figure (2)
plot ( Time , FzRL ); hold on ; plot ( Time , FzRR ); hold on
plot ( Time , F3z ,'--'); hold on ; plot ( Time , F4z ,'--')
xlabel ('time (s)')
ylabel ('Normal force (N)')
%ylim ([ -1000 14000])
title ('Rear Wheel Normal Forces ')
grid on
legend ('Actual Left Wheel NF ',' Actual Right Wheel NF ' ,...
'Estimated Left Wheel NF ','Estimated Right Wheel NF ')

sf = (length(Time):1);
sr = (length(Time):1);

for i =1:length(Time)
x1(i) = abs(FzFL(i) - F1z(i));
x2(i) = abs(FzFR(i) - F2z(i));
x3(i) = abs(FzRL(i) - F3z(i));
x4(i) = abs(FzRR(i) - F4z(i));

if(FzFL(i)<front_z_s )||(FzFR(i)<front_z_s)
    sf(i) = 1;
else
    sf(i) = 0;
end
    if(FzRL(i)<rear_z_s)||(FzRR(i)<rear_z_s)
        sr(i) = 1;
    else
        sr(i) = 0;
    end
end
rms1 = rms(x1,'all');
rms2 = rms(x2,'all');
rms3 = rms(x3,'all');
rms4 = rms(x4,'all');
figure(3)
subplot(2,1,1)
plot(Time,sf)
xlabel('time(s)')
ylabel('Warning front')
grid on
subplot(2,1,2)
plot(Time,sr)
xlabel('time(s)')
ylabel('Warning rear')
grid on
sgtitle('Warning over static loads on wheels ')
