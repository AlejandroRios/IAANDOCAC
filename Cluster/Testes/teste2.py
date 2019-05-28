import matplotlib.pyplot as plt
from traffic.data import opensky
from traffic.data import eurofirs
from traffic.drawing import EuroPP, countries, location

flight = opensky.history("2017-02-05", callsign="EZY158T")
flight

with plt.style.context('traffic'):
    ax = plt.axes(projection=EuroPP())

    ax.add_feature(countries())
    ax.gridlines()

    ax.set_extent(location('France'))

    for name, fir in eurofirs.items():
        if name.startswith('LF'):
            fir.plot(ax, edgecolor='navy', linewidth=2, linestyle='dotted')
            fir.point.plot(ax, alpha=0,  text_kw=dict(s=name, fontsize=16, horizontalalignment='center'))

    flight.plot(ax, color='gray', linestyle='dashed')
    flight.before('2017-02-05 16:12').plot(ax, color='#aa3a3a')
    flight.at('2017-02-05 16:12').plot(
        ax, s=15, marker='o', text_kw=dict(s="16:12", horizontalalignment='right',), shift=dict(units='dots', x=-10)
    )

plt.show()
