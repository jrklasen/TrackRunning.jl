"""
Distance in meters
"""
function distance(run::Run)
    lon = run.lon * pi / 180
    lat = run.lat * pi / 180
    d = zeros(length(lat))
    for i in 2:length(lat)
        x = (lon[i] - lon[i - 1]) * cos(mean(lat[[i - 1, i]]))
        y = lat[i] - lat[i - 1]
        # authalic radius of 6371007.2 meters
        d[i] = d[i - 1] + sqrt(x^2 + y^2) * 6371007.2
    end
   d
end
