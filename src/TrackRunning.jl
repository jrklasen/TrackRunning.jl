module TrackRunning

using DataFrames: readtable, isna, deleterows!
using FileIO: load
using Images: channelview, rawview, permuteddimsview
using PyPlot: xticks, yticks, imshow

export readttwatch
export dist_m, time_sec, speed_kmh, pace_minkm
export mapzoom, mapprojection, downloadmap, showmap

include("run.jl")
include("io.jl")
include("metric.jl")
include("map.jl")
include("plot.jl")

end # module
