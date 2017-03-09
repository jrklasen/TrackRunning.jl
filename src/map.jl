immutable MapCoordinates
    lon_center::AbstractFloat
    lat_center::AbstractFloat
    lon_left::AbstractFloat
    lat_top::AbstractFloat
    lon_right::AbstractFloat
    lat_bottom::AbstractFloat
    x_left::AbstractFloat
    y_top::AbstractFloat
    x_right::AbstractFloat
    y_bottom::AbstractFloat
    zoom::Integer
end

"""
    `mapzoom(run)` calculates the according map zoom-value for a given data set.
"""
function mapzoom(run::Run, minzoom::Integer = 0, maxzoom::Integer = 21)::Integer
    lon = [maximum(run.lon); minimum(run.lon)]
    lat = [maximum(run.lat); minimum(run.lat)]
    # geographic coordinate to world cooredinates
    x_wc = (lon .+ 180) ./ 360
    y_temp = log.(tan.(pi / 4 .+ lat .* pi ./ 360))
    y_wc = .5 .- broadcast(y -> min(max(y, -pi), pi), y_temp) ./ (2 * pi)
    # zoom
    x_zoom = floor(log2(2.5 / abs(x_wc[2] - x_wc[1])))
    y_zoom = floor(log2(2.5 / abs(y_wc[2] - y_wc[1])))
    return max(min(x_zoom, y_zoom, maxzoom), minzoom)
end

"""
    `mapprojection(run)` calculates the according geographic coordinates and world
    coordinates for a given data set.

"""
function mapprojection(run::Run, minzoom::Integer = 0, maxzoom::Integer = 21)
  zoom = mapzoom(run, minzoom, maxzoom)
  tpz = 2^zoom
  lon_center = mean([maximum(run.lon); minimum(run.lon)])
  lat_center = mean([maximum(run.lat); minimum(run.lat)])
  # world coordinates
  x_wc = (lon_center + 180) / 360
  y_wc_temp = log(tan(pi / 4 + lat_center * pi / 360))
  y_wc = .5 - min(max(y_wc_temp, -pi), pi) / (2 * pi)
  # world cooredinates to pixel coordinates
  x = x_wc * tpz .+ [-1.25,  1.25]
  y = y_wc * tpz .+ [-1.25,  1.25]
  # pixel coordinates to world coordinates
  x_wc_zoom = x ./ tpz
  y_wc_zoom = y ./ tpz
  # world cooredinates to geographic coordinate
  lon_zoom = (x_wc_zoom .* 360) .- 180
  lat_zoom = (atan.(exp.((.5 .- y_wc_zoom) .* (2 * pi))) .- pi ./ 4) .* 360 ./ pi
  # section box
  out = MapCoordinates(lon_center, lat_center,
                       lon_zoom[1], lat_zoom[1], lon_zoom[2], lat_zoom[2],
                       x[1], y[1], x[2], y[2],
                       zoom)
  return out
end

"""
    `googlemap(coor, maptype)` downloads the map for a given data set.

Download a map from Google.
* coor: Coordinates for map.
* maptype: A string specifying the map of the type: "terrain".

See:
https://developers.google.com/maps/documentation/static-maps/intro#URL_Parameters
https://developers.google.com/maps/terms
"""
function downloadmap(mapcoor, mapservice::AbstractString="google",
    maptype::AbstractString="terrain")
    if mapservice == "google"
        googlemaps = ["roadmap", "satellite", "terrain", "hybrid"]
        if !any(maptype .== googlemaps)
            error("for google maps the ``maptype`` has to be one of the following: $googlemaps")
        end
        # url for google map
        mapurl = String("https://maps.googleapis.com/maps/api/staticmap?center=$(mapcoor.lat_center),$(mapcoor.lon_center)&maptype=$maptype&zoom=$(mapcoor.zoom)&size=640x640&scale=2&format=png8&language=en-EN")
        # download google map
        temp = download(mapurl)
    else
        error("map service $googlemaps not implemented")
    end
    temp
end
