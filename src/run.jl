immutable Run
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
            error("'data' has incorrect length")
        end
        if length(lap) == 0
            lap = one(n)
        elseif length(lap) != n
            error("'lap' has incorrect length")
        end
        if  length(ele) != n & length(ele) != 0
            error("'ele' has incorrect length")
        end
        if  length(hr) != n & length(hr) != 0
            error("'hr' has incorrect length")
        end
        new(date, lon, lat, ele, lap, hr)
    end
end
