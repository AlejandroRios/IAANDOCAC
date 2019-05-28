
from traffic.data import eurofirs
from traffic.data import opensky
from traffic.drawing import EuroPP, countries, location
from traffic.data import airports

from traffic.core.logging import loglevel
loglevel('INFO')

bounds = airports['EGLL','LFPG'];

t = opensky.history(
    "2018-10-01 11:50", "2018-10-01 12:50",
    other_params = bounds
)

print(t)

# Export methods
# Flight.to_csv('/home/alejandro/Documents/Github/traffic  france1.csv', *args, **kwargs)
# t.to_csv('france2.csv', *args, **kwargs)
t.to_csv('/home/alejandro/Documents/Github/traffic/  airports.csv')


    SELECT track.pos AS hit, icao24, callsign, track.item.time AS time, track.item.latitude AS lat, track.item.longitude AS lon, track.item.heading AS heading,track.item.altitude AS alt, estdepartureairport, estarrivalairport, track.item.onground AS onground
    FROM flights_data4, flights_data4.track
    WHERE estdepartureairport='LFPG' AND estarrivalairport='EGLL' AND day>=1538437800 AND day<=1538524200;
