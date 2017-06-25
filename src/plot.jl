"""
    `showmap(run)` plotting of map for a given data set.
"""
function showmap(run::Run, minzoom::Integer = 0, maxzoom::Integer = 21,
    mapservice::AbstractString="google", maptype::AbstractString="roadmap")
    mapcoor = mapprojection(run)
    mapfile = downloadmap(mapcoor)
    runmap = permuteddimsview(rawview(channelview(load(mapfile))), (2, 3, 1)) / 256
    xylim = [mapcoor.lon_left, mapcoor.lon_right, mapcoor.lat_bottom, mapcoor.lat_top]
    xticks([])
    yticks([])
    imshow(runmap, origin="upper", extent=xylim, aspect=1.5)
end

"""
    `plotrun(run::Run)` plot running data.
"""
function plotrun(run::Run)
    kmh = speed_kmh(run)
    kmh = kmh / maximum(kmh)
    scatter(run.lon[2:end], run.lat[2:end], c = kmh, cmap = ColorMap(:coolwarm), s = 1)
end
