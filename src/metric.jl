"""
    `dist_m(run)` estimation of the distance in meters.
"""
function dist_m(run::Run)
    lon = run.lon * pi / 180
    lat = run.lat * pi / 180
    d = zeros(length(lat) - 1)
    for i in 2:length(lat)
        x = (lon[i] - lon[i - 1]) * cos(mean(lat[[i - 1, i]]))
        y = lat[i] - lat[i - 1]
        # authalic radius of 6371007.2 meters
        d[i - 1] = sqrt(x^2 + y^2) * 6371007.2
    end
   cumsum(d)
end

"""
    `time_sec(run)` calculates the time in sec.
"""
function time_sec(run::Run)
    cumsum(diff(run.date) / Base.Dates.Millisecond(1000))
end

"""
    `speed_kmh(run)` calculates the speed in km/h.
"""
function speed_kmh(run::Run)
    m = diff(vcat(0.0, dist_m(run)))
    sec = diff(vcat(0.0, time_sec(run)))
    kmh = (m ./ 1000) ./ (sec ./ 3600)
    kmh
end

"""
    `pace_minkm(run)` calculates the pace in min/km.
"""
function pace_minkm(run::Run)
    m = diff(vcat(0.0, dist_m(run)))
    sec = diff(vcat(0.0, time_sec(run)))
    minkm = (sec ./ 60) ./ (m ./ 1000)
    minkm
end
