% Inge Geo Uebung 3
% Ziqing Yu 3218051
% 12/12/2019

clc
clear all;
close all;
fileID = fopen('Uebung3.txt','w');

rho = 0.85;
g = 9.8;
q = 0.06;
fr = 0.4;
v = 70 / 3.6;
b = 6; 
% mindeste Radius
mR1 = (1 - fr * q) * v^2 / (q + fr) / g;
mR2 = v^2 / (rho + g * q);
A = 150;

R = 350;  % Radius
fprintf(fileID,'Radius von Kreis: %8.8f,',R);
fprintf(fileID,'\r\n');


L = A^2 / R;
fprintf(fileID,'Laenge von Klotoid: %8.8f,',L);
fprintf(fileID,'\r\n');
% gegebene Punkte
x51 = 1997.3408;
y51 = 829.7327;
x52 = 2038.5280;
y52 = 800.8240;
x61 = 2371.9474;
y61 = 719.0208;
x62 = 2410.8887;
y62 = 724.2274;

% Richtungen 
t1 = atan2(y52 - y51, x52 - x51);
t2 = atan2(y62 - y61, x62 - x61);

alpha = 2 * pi - (t1 - t2);

tau = L / (2 * R);  % Tangentenwinkel

l = L / A;
x = l - l^5 / 40 + l^9 / 3456;
y = l^3 / 6 - l^7/336 + l^11/42240;
y = y * A;
x = x * A;

ta = x - y / tan (tau);
te = sqrt((x - ta)^2 + y^2);

dR = y - R * (1 - cos(tau));
xlot = x - R*sin(tau);
TG = xlot + (R + dR)*tan(alpha/2);

% Klotoidanfangspunkte
[x0,y0] = schnittpunkt(x51,y51,x52,y52,x61,y61,x62,y62);
xa1 = x0 - TG * cos(t1);
ya1 = y0 - TG * sin(t1);
fprintf(fileID,'xa1: %8.8f,',xa1);
fprintf(fileID,'\r\n');
fprintf(fileID,'ya1: %8.8f,', ya1);
fprintf(fileID,'\r\n');

xa2 = x0 + TG * cos(t2);
ya2 = y0 + TG * sin(t2);
fprintf(fileID,'xa2: %8.8f,',xa2);
fprintf(fileID,'\r\n');
fprintf(fileID,'ya2: %8.8f,', ya2);
fprintf(fileID,'\r\n');

xk1 = xa1 + ta * cos(t1);
yk1 = ya1 + ta * sin(t1);
tk1k2 = t1 + tau;
xe1 = xk1 + te * cos(tk1k2);
ye1 = yk1 + te * sin(tk1k2);
fprintf(fileID,'xe1: %8.8f,',xe1);
fprintf(fileID,'\r\n');
fprintf(fileID,'ye1: %8.8f,', ye1);
fprintf(fileID,'\r\n');


t2 = t2 - pi;          % wichtig
xk2 = xa2 + ta * cos(t2);
yk2 = ya2 + ta * sin(t2);
tk3k4 = t2 - tau;
xe2 = xk2 + te * cos(tk3k4);
ye2 = yk2 + te * sin(tk3k4);
fprintf(fileID,'xe2: %8.8f,',xe2);
fprintf(fileID,'\r\n');
fprintf(fileID,'ye2: %8.8f,', ye2);
fprintf(fileID,'\r\n');

% Mittelpunkt des Kreises
xm = xe1 + R * cos(t1 + tau + pi / 2);
ym = ye1 + R * sin(t1 + tau + pi / 2);
fprintf(fileID,'x Kreismitellpunkt: %8.8f,',xm);
fprintf(fileID,'\r\n');
fprintf(fileID,'y Kreismittelpunkt: %8.8f,', ym);
fprintf(fileID,'\r\n');




% Zwischenpunkten
Lz = 20:20:L;
s = length(Lz);
lz = Lz / A;
xz = lz - lz.^5 / 40 + lz.^9 / 3456;
yz= lz.^3 / 6 - lz.^7/336 + lz.^11/42240;
yz = yz * A;
xz = xz * A;
R1 = [cos(t1), -sin(t1); sin(t1), cos(t1)];
koor_z1 = R1 * [xz; yz] + [xa1; ya1];
R2 = [cos(t2-pi), -sin(t2-pi); sin(t2-pi), cos(t2-pi)];
koor_z2 = R2 * [-xz; yz] + [xa2; ya2];

% Laenge
L_klotoid = L; 
L_gerade1 = sqrt((x51 - xa1)^2 + (y51 - ya1)^2);
L_gerade2 = sqrt((x62 - xa2)^2 + (y62 - ya2)^2);
t_me1 = atan2(ym - ye1, xm - xe1);
t_me2 = atan2(ym - ye2, xm - xe2);
beta = t_me2 - t_me1;
L_kreisbogen = R * beta;

figure, scatter(x51,y51);
hold on
scatter(x52,y52);
scatter(x61,y61);
scatter(x62,y62);
scatter(xa1,ya1,'+');
scatter(xa2,ya2,'+');
scatter(xe1,ye1,'+');
scatter(xe2,ye2,'+');
scatter(x0,y0,'.');
scatter(xm,ym,'.');
scatter(koor_z1(1,:),koor_z1(2,:),'*')
scatter(koor_z2(1,:),koor_z2(2,:),'*')


% langsprofil
s_5152 = sqrt((x51 - x52)^2 + (y51 - y52)^2);
s_6162 = sqrt((x61 - x62)^2 + (y61 - y62)^2);
l = zeros(23,1);
l(1) = 0;
l(2) = l(1) + s_5152;
l(3) = l(1) + L_gerade1;
l(4) = l(3) + 20;
l(5) = l(4) + 20;
l(6) = l(5) + 20;
l(7) = l(3) + L_klotoid;
for i = 1:10
    l(i + 7) = l(i + 6) + 20;
end
l(18) = l(17) + L_klotoid -60;
l(19) = l(18) + 20;
l(20) = l(19) + 20;
l(21) = l(20) + 20;
l(22) = l(21) + L_gerade2 - s_6162;
l(23) = l(21) + L_gerade2;
h = [293.8, 294.8, 295.8, 296.5, 296.8, 297.5, 297.6, 298.2, 298.7, 299.2, 299.8, 300.5, 301, 301.5, 302, 302.2, 302.3, 302.2, 301.8, 301.5, 301.1, 300.3, 299.8];
figure, plot(l,h)
pbaspect([1000 100 1])
xlabel('Laenge')
ylabel('Hoehen')