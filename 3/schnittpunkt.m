function [x,y] = schnittpunkt(x1,y1,x2,y2,x3,y3,x4,y4)
x = (x2 * (y1 - y2) / (x1 - x2) - x4 * (y3 - y4) / (x3 - x4) + (y4 - y2)) / ((y1 - y2) / (x1 - x2) - (y3 - y4) / (x3 - x4));
y = (x - x2) * (y1 - y2) / (x1 - x2) + y2;
end