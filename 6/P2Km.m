function[xm,ym] = P2Km(xa, ya, xb, yb, xc, yc)
k1 = (yb - ya) / (xb - xa);
k2 = (yc - yb) / (xc - xb);
x1 = (xa + xb) / 2;
y1 = (ya + yb) / 2;
x2 = (xb + xc) / 2;
y2 = (yb + yc) / 2;
ym = (k1 * y1 - k2 * y2 + x2 - x1) / (k1 - k2);
xm = k1 * (ym - y1) + x1;
end