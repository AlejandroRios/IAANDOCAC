import numpy as np
import scipy as sp
import scipy.interpolate
import matplotlib.pyplot as plt

# Generate some random data
y = (np.random.random(10) - 0.5).cumsum()
x = np.arange(y.size)

# Interpolate the data using a cubic spline to "new_length" samples
new_length = 50
new_x = np.linspace(x.min(), x.max(), new_length)
new_y = sp.interpolate.interp1d(x, y, kind='cubic')(new_x)

# Plot the results
plt.figure()
plt.subplot(2,1,1)
plt.plot(x, y, 'bo-')
plt.title('Using 1D Cubic Spline Interpolation')

plt.subplot(2,1,2)
plt.plot(new_x, new_y, 'ro-')

plt.show()
