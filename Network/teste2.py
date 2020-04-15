import pulp
prob = pulp.LpProblem("AirlineNetwork", pulp.LpMinimize)

# Airports departure
airports_dep = ['Albuquerque','Atlanta','Boston','Charlotte','Chicago','Cincinnati','Cleveland']

# Airports arrival
airports_arr = ['Albuquerque','Atlanta','Boston','Charlotte','Chicago','Cincinnati','Cleveland']

# Demand
demand = {'Albuquerque':10613,
        'Atlanta':58901,
        'Boston':53098,
        'Charlotte':20125,
        'Chicago':84861,
        'Cincinnati':6682,
        'Cleveland':22158}

# Plane characteristics
Plane_A = {'w':5000,
        'r':1063,
        'v':252,
        'f':1107,
        'm':370}

# Airports disnatances
distances = {'Albuquerque':{'Atlanta':1407,'Boston':2225,'Charlotte':1641,'Chicago':1335,'Cincinnati':1391,'Cleveland':1603},
        'Atlanta':{'Boston':1075,'Charlotte':240,'Chicago':716,'Cincinnati':460,'Cleveland':712},
        'Boston':{'Charlotte':841,'Chicago':1015,'Cincinnati':869,'Cleveland':648},
        'Charlotte':{'Chicago':785,'Cincinnati':487,'Cleveland':516},
        'Chicago':{'Cincinnati':299,'Cleveland':355},
        'Cincinnati':{'Cleveland':252}}

# Demand
distances = {'Albuquerque':{'Atlanta':2356,'Boston':2051,'Charlotte':673,'Chicago':4572,'Cincinnati':214,'Cleveland':747},	
        'Atlanta':{'Boston':14045,'Charlotte':4610,'Chicago':31313,'Cincinnati':1465,'Cleveland':5112},		
        'Boston':{'Charlotte':4014,'Chicago':27261,'Cincinnati':1276,'Cleveland':4451},	
        'Charlotte':{'Chicago':8948,'Cincinnati':419,'Cleveland':1461},
        'Chicago':{'Cincinnati':2844,'Cleveland':9923},
        'Cincinnati':{'Cleveland':464}}

# Cost of operating small size plane from city i to k
aik = Plane_A['f']+Plane_A['m']*(2*distances)/Plane_A['V']

# A = [(i, j) for i in V for j in V] # Arcos
# c = {(i, j): np.hypot(loc_x[i]-loc_x[j], loc_y[i]-loc_y[j]) for i, j in A} # cost of travel from arc (i,j)


aik = Plane_A['f']+Plane_A['m']*(2*distances)/Plane_A['V']











				
				
			
		

