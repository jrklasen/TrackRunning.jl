"""
    `time_sec(run)` calculates the time in sec.
"""
function time_sec(run::Run)
    cumsum(diff(run.date) / Base.Dates.Millisecond(1000))
end

"""
    `dist_m(run, smoothing = true, λ = 500.0)` estimation of the distance in meters.
"""
function dist_m(run::Run;
    smoothing::Bool = true, λ::AbstractFloat = 500.0)
    lon = run.lon * pi / 180
    lat = run.lat * pi / 180
    m1 = zeros(length(lat) - 1)
    for i in 2:length(lat)
        x = (lon[i] - lon[i - 1]) * cos(mean(lat[[i - 1, i]]))
        y = lat[i] - lat[i - 1]
        # authalic radius of 6371007.2 meters
        m1[i - 1] = sqrt(x^2 + y^2) * 6371007.2
    end
    if smoothing
        sec = time_sec(run)
        m1 = predict(fit(SmoothingSpline, sec, m1, λ))
        m1[find(m1 .< 0.0)] .= 0
    end
    m = cumsum(m1)
    m
end

"""
    `speed_kmh(run, smoothing = true, λ = 500.0)` calculates the speed in km/h.
"""
function speed_kmh(run::Run;
    smoothing::Bool = true, λ::AbstractFloat = 500.0)
    m1 = diff(vcat(0.0, dist_m(run, smoothing = smoothing, λ = λ)))
    sec = time_sec(run)
    sec1 = diff(vcat(0.0, sec))
    kmh = (m1 ./ 1000) ./ (sec1 ./ 3600)
    kmh
end

"""
    `pace_minkm(run, smoothing = true, λ = 500.0)` calculates the pace in min/km.
"""
function pace_minkm(run::Run;
    smoothing::Bool = true, λ::AbstractFloat = 500.0)
    m = diff(vcat(0.0, dist_m(run, smoothing = smoothing, λ = λ)))
    sec = diff(vcat(0.0, time_sec(run)))
    minkm = (sec ./ 60) ./ (m ./ 1000)
    minkm
end
