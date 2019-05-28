import matplotlib.pyplot as plt
from traffic.data import opensky
from traffic.data import eurofirs
from traffic.drawing import EuroPP, countries, location


from traffic.core.logging import loglevel
loglevel('INFO')

t = opensky.history(
    "2018-10-01 11:50", "2018-10-01 12:10",
    bounds=eurofirs['LFBB']
)


from traffic.data import airports

with plt.style.context('traffic'):

    fig, (ax1, ax2) = plt.subplots(
        1, 2, figsize=(15, 10),
        subplot_kw=dict(projection=EuroPP())
    )

    for ax in (ax1, ax2):
        ax.add_feature(countries())
        ax.set_extent(eurofirs['LFBB'])

        for airport_code in ('LFBO', 'LFBD'):
            airport_code.plot(
                ax, color='firebrick'
            )
            airport_code.point.plot(
                ax, alpha=0,
                text_kw=dict(
                    s=airport_code,
                    bbox=dict(
                        facecolor='firebrick',
                        alpha=0.3,
                        boxstyle='round')
                )
            )

        eurofirs['LFBB'].plot(
            ax, edgecolor='navy',
            linewidth=2,
            linestyle='dotted')

    t.plot(ax1)
    t.query('altitude < 20000').plot(ax2)

plt.show()
