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
        if  length(ele) != n & length(ele) != 0
            error("length of 'ele' is not zero or equal to the length of 'lon' and 'lat'")
        end
        if  length(hr) != n & length(hr) != 0
            error("length of 'hr' is not zero or equal to the length of 'lon' and 'lat'")
        end
        new(date, lon, lat, ele, lap, hr)
    end
end
