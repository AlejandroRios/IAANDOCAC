


t = linspace(-1.5,1,10);
u = linspace(-1.5,1,10);
x1 = t;
y1 = t.^2 + t - 1;

x2 = u;
y2 = 2 - u.^2;

P = [x1;y1]
Q = [x2;y2]


[hd D] = HausdorffDist(P,Q)

plot(x1,y1)