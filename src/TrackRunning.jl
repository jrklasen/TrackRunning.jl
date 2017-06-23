module TrackRunning

using DataFrames: readtable, isna, deleterows!
using FileIO: load
using Images: channelview, rawview, permuteddimsview
using PyPlot: xticks, yticks, imshow

export readttwatch
export distance, time, speed, pace
export mapzoom, mapprojection, downloadmap, mapshow

include("run.jl")
include("io.jl")
include("metric.jl")
include("map.jl")
include("plot.jl")

end # module
