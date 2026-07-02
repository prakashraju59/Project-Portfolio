%%handlingdiagram
y=ay./9.812;
R=vx./yawRate;
x=(SteerAng_FR+SteerAng_FL)./2;
z=((2.98./R)-x)*(180/pi);
%%
y2=ay./9.812;
R2=vx./yawrate;
x2=(SteerAng_FR+SteerAng_FL)/2;
z2=((2.98./R2)-x2)*(180/pi);
%%
y3=ay./9.812;
R3=vx./yawrate;
x3=(SteerAng_FR+SteerAng_FL)/2;
z3=((2.98./R3)-x3)*(180/pi);
%%
plot(z,y);hold on
plot(z2,y2);hold on
plot(z3,y3);hold off
xlabel('side slip balance in deg');
ylabel('normalized acceleration in g');
legend('IC','EV-50/50','tuneEV-50/50')
title('Handing diagram')
grid on
