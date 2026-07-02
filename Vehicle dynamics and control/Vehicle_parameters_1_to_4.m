% vehicle parameter

g = 9.81; % gravity m/s^2
m = 2296.758; % vehicle weight
lr = 1.79; % cog to rear logaccel in m
lf = 1.194; % cog to front logaccel in m
h = 0.678; % cog height in m
h_rcf = 0.1553; % front rc height in m
h_rcr = 0.155; % rear rc height in m
wf = 1.676; % front wheel base in m
wr = 1.668; % rear wheel base in m
Jx = 1204.674; % inertia tensor in Ixx
Jy = 3643.363; % inertia tensor in Iyy
Jz = 4027.903; % inertia tensor in Izz
caf = 17687.0; % anti roll bar stiffness front
car = 15508.6; % anti roll bar stiffness rear
csf = 34250; % spring stiffness front
csr = 42795; % spring stiffness rear
cf = 2*(csf + 2*caf)*((wf/2)^2) ; % roll stiffness front
cr = 2*(csr + 2*car)*((wr/2)^2) ; % roll stiffness rear

