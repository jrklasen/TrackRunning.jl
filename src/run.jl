struct Run
    date::Vector{DateTime}
    lon::Vector{AbstractFloat}
    lat::Vector{AbstractFloat}
    ele::Vector{AbstractFloat}
    lap::Vector{Integer}
    hr::Vector{Integer}
    function Run(date, lon, lat,
        ele=Vector{AbstractFloat}[], lap=Vector{Integer}[], hr=Vector{Integer}[])
        n = length(lon)
        if length(lat) != n
            error("'lon' and 'lat' differ in length")
        end
        if length(date) != n
            error("length of 'data' is not equal to the length of 'lon' and 'lat'")
        end
        if length(lap) == 0
            lap = one(n)
        elseif length(lap) != n
            error("length of 'lap' is not equal to the length of 'lon' and 'lat'")
        end
        if length(ele) != n & length(ele) != 0
            error("length of 'ele' is not zero or equal to the length of 'lon' and 'lat'")
        end
        if length(hr) != n & length(hr) != 0
            error("length of 'hr' is not zero or equal to the length of 'lon' and 'lat'")
        end
        new(date, lon, lat, ele, lap, hr)
    end
end

# Methods
Base.length(run::Run) = length(run.date)

## Indexing
Base.endof(run::Run) = length(run)
function Base.getindex(run::Run, i::Number)
    i = convert(Int, i)
    1 <= i <= length(run) || throw(BoundsError(run, i))
    date = [run.date[i]]
    lon = [run.lon[i]]
    lat = [run.lat[i]]
    if length(run.ele) == 0
        ele = run.ele
    else
        ele = [run.ele[i]]
    end
    lap = [run.lap[i]]
    if length(run.hr) == 0
        hr = run.hr
    else
        hr = [run.hr[i]]
    end
    Run(date, lon, lat, ele, lap, hr)
end
function Base.getindex(run::Run, i)
    1 <= minimum(i) <= length(run) || throw(BoundsError(run, i))
    1 <= maximum(i) <= length(run) || throw(BoundsError(run, i))
    date = [run.date[j] for j in i]
    lon = [run.lon[j] for j in i]
    lat = [run.lat[j] for j in i]
    if length(run.ele) == 0
        ele = run.ele
    else
        ele = [run.ele[j] for j in i]
    end
    lap = [run.lap[j] for j in i]
    if length(run.hr) == 0
        hr = run.hr
    else
        hr = [run.hr[j] for j in i]
    end
    Run(date, lon, lat, ele, lap, hr)
end


## Iteration
Base.start(run::Run) = 1
Base.next(run::Run, state) = (run[1], state + 1)
Base.done(run::Run, state) = state > length(run)