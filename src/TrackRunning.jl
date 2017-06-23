module TrackRunning

using DataFrames: readtable, isna, deleterows!
using FileIO: load
using Images: channelview, rawview, permuteddimsview
using PyPlot: xticks, yticks, imshow

export readttwatch, mapzoom, mapprojection, downloadmap, mapshow, distance

include("run.jl")
include("io.jl")
include("metric.jl")
include("map.jl")
include("plot.jl")

end # module
