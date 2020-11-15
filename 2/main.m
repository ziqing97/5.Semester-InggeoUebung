% Inge Geo Uebung 2
% Ziqing Yu 3218051
% Erstellt am 29/11/2019

clc
clear all;
close all;
% 
T = 10e-3;
p = 1/3;
TM = T * sqrt(2 * p - p^2);
k = 1.96;
sigma = TM / 2 / k;
% 

x_a = 0;
y_a = 0;
x_b = 200;
y_b = 0;

x_s = 100; 
y_s = -20.5;

S = sqrt(100^2 + 20.5^2);
alpha = acos(100/S);

sigma_xa = 1.5e-3;
sigma_ya = 1.5e-3;
sigma_xb = 1.8e-3;
sigma_yb = 1.8e-3;

para1 = atan2((y_b - y_a), (x_b - x_a)) - alpha;
para2 = ((y_b - y_a)/ (x_b - x_a))^2 + 1;
para3 = -(y_b - y_a)/(x_b - x_a)^2;

xabl_xa = 1 - S * (sin(para1) * 1 / (para2) * para3 * (-1));
xabl_xb = -S * sin(para1) / (para2) * (para3);
xabl_ya = -S * sin(para1) / (para2) * (-1) / (x_b - x_a);
xabl_yb = -S * sin(para1) / (para2) / (x_b - x_a);
xabl_s = cos(para1);
xab1_alpha = -S * sin(para1) * (-1);

yabl_xa = S * cos(para1) / para2 * para3 * (-1);
yabl_xb = S * cos(para1) / para2 * para3;
yabl_ya = 1 + S * cos(para1) / para2 / (x_b - x_a) * (-1);
yabl_yb = S * cos(para1) / para2 / (x_b - x_a); 
yabl_s = sin(para1);
yabl_alpha = S * cos(para1) * (-1);

F1 = [xabl_xa^2, xabl_xb^2, xabl_ya^2, xabl_yb^2;
      yabl_xa^2, yabl_xb^2, yabl_ya^2, yabl_yb^2];
 
F2 =[xabl_s^2, xab1_alpha^2; 
     yabl_s^2, yabl_alpha^2];

y1 = [sigma_xa^2; sigma_xb^2; sigma_ya^2; sigma_yb^2];
y2 = [sigma^2; sigma^2];

x = inv(F2) * (y2 - F1 * y1);
sigma_s = sqrt(x(1));
sigma_alpha = sqrt(x(2)) / pi * 200;