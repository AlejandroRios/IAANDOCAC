from cvxopt.modeling import *
from cvxopt import matrix, solvers
from cvxopt import matrix


# x = variable()
# y = variable()

# r1 = 2*x + y <= 3
# r2 = x + 2*y <= 3
# r3 = x >= 0
# r4 = y >= 0

# lpl = op(-4*x - 5*y,[r1,r2,r3,r4])
# lpl.solve()
# lpl.status

# print(lpl.objective.value())


# A = matrix([ [-1.0, -1.0, 0.0, 1.0], [1.0, -1.0, -1.0, -2.0] ])

# b = matrix([ 1.0, -2.0, 0.0, 4.0 ])

# c = matrix([ 2.0, 1.0 ])

# sol=solvers.lp(c,A,b)

# print(sol['x'])

N = matrix([ [13,  12,  10,  9,  10,  11,  10,  7,  5,  12,  12,  10,  4,  10,  3],
             [11,  9,  10,  7,  6,  6,  12,  11,  11,  7,  8,  5,  6,  6,  3],
             [6,   7,  8,  3,  6,  7,  8,  6,  5,  8,  9,  9,  5,  6,  2],
             [2,   1,  2,  2,  2,  3,  5,  2,  2,  3,  3,  3,  2,  2,  1],
             [9,   9,  11,  6,  9,  8,  11,  13,  7,  10,  9,  10,  7,  5,  4],
             [3,   3,  5,  4,  3,  3,  5,  3,  4,  2,  5,  4,  3,  4,  3],
             [5,   4,  7,  5,  3,  4,  5,  4,  7,  4,  6,  6,  3,  3,  2],
             [6,   6,  7,  7,  5,  5,  6,  7,  7,  4,  7,  5,  9,  5,  5],
             [24,  21,  20,  16,  16,  17,  22,  18,  16,  19,  20,  15,  10,  16,  6],
             [8,   8,  10,  5,  8,  10,  13,  8,  7,  11,  12,  12,  7,  8,  3],
             [12,  12,  16,  10,  12,  11,  16,  16,  11,  12,  14,  14,  10,  9,  7],
             [11,  10,  14,  12,  8,  9,  11,  11,  14,  8,  13,  11,  12,  8,  7] ])

C = matrix([[13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13],
            [15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15],
            [18,  18,  18,  18,  18,  18,  18,  18,  18,  18,  18,  18,  18,  18,  18],
            [11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11,  11],
            [15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15],
            [13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13],
            [13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13,  13],
            [15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15,  15],
            [19,  19,  19,  19,  19,  19,  19,  19,  19,  19,  19,  19,  19,  19,  19],
            [21,  21,  21,  21,  21,  21,  21,  21,  21,  21,  21,  21,  21,  21,  21],
            [20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20],
            [20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20,  20]])

a = matrix([[1,  0,  0,  0,  0,  0,  0,  0],
            [0,  1,  0,  0,  0,  0,  0,  0],
            [0,  0,  1,  0,  0,  0,  0,  0],
            [0,  0,  0,  1,  0,  0,  0,  0],
            [0,  0,  0,  0,  1,  0,  0,  0],
            [0,  0,  0,  0,  0,  1,  0,  0],
            [0,  0,  0,  0,  0,  0,  1,  0],
            [0,  0,  0,  0,  0,  0,  0,  1],
            [1,  1,  0,  0,  0,  0,  0,  0],
            [0,  0,  1,  1,  0,  0,  0,  0],
            [0,  0,  0,  0,  1,  1,  0,  0],
            [0,  0,  0,  0,  0,  0,  1,  1] ])


num_sectors = 8 # NUMBER OF SECTORS
num_sectorconfigs = 12 # NUMBER OF SECTOR CONFIGURATIONS
num_hours = 15 # NUMBER OF TIME PERIODS IN THE PLANNING HORIZON

alpha = 1  # WEIGHT OF THE COST MINIMIZATION COMPONENT IN THE OBJECTIVE FUNCTION
beta = 1   # WEIGHT OF THE TRAFFIC LOAD BALANCING COMPONENT IN THE OBJECTIVE FUNCTION


variable =  x(num_sectorconfigs,num_hours) binary
variable =  y(1,num_hours)

minimize(alpha*sum(x(:)) + beta*sum(y))

subject to

for j = 1:num_sectors
    for t = 1:num_hours
        sum(a(:,j).*x(:,t)) == 1
    end
end

for i = 1:num_sectorconfigs
    for t = 1:num_hours
        x(i,t)*N(i,t) - C(i,t) <= 0
        y(1,t) - x(i,t)*N(i,t) >= 0
    end
end

for t = 1:num_hours
    y(1,t) >= 0
end

cvx_end




# OUTPUT

# NUMBER OF CONTROL POSITIONS OPENED
num_controlpositions = sum(x(:))

# MAXIMUM TRAFFIC LOAD
traffic_load = full(x.*N)
max_traffic_load = max(traffic_load)
avg_max_traffic_load = round(mean(max_traffic_load))

# STANDARD DEVIATION OF TRAFFIC LOADS
traffic_load(traffic_load == 0) = NaN
std_traffic_load = nanstd(traffic_load)
avg_std_traffic_load = mean(std_traffic_load)

# NUMBER OF RECONFIGURATIONS
num_reconfig = 0
for t=2:num_hours
    if sum(abs(x(:,t)-x(:,t-1))) ~= 0
        num_reconfig = num_reconfig + 1
    end
end


output = table(num_controlpositions, avg_max_traffic_load, avg_std_traffic_load, num_reconfig)







# STATIC SOLUTION

x(1:8,:)=1
x(9:12,:)=0

