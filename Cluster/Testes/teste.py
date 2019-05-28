import matplotlib.pyplot as plt

from traffic.data import opensky
from traffic.drawing import EuroPP, countries

sv = opensky.api_states()

with plt.style.context('traffic'):
    fig, ax = plt.subplots(subplot_kw=dict(projection=EuroPP()))
    ax.add_feature(countries())
    ax.gridlines()
    ax.set_extent((-7, 15, 40, 55))

    sv.plot(ax, s=10)

import random
sv = random.sample(sv.callsigns, 6)
print(sv)
flight = sv['']
print(flight)
# print(random)

# plt.show()
