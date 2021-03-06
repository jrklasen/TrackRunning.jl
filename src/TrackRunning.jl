module TrackRunning

using DataFrames: readtable, isna, deleterows!
using FileIO: load
using Images: channelview, rawview, permuteddimsview
using SmoothingSplines: predict, fit, SmoothingSpline
using Reexport
@reexport using PyPlot #: xticks, yticks, imshow, scatter, ColorMap

export readttwatch, readrun
export dist_m, time_sec, speed_kmh, pace_minkm
export mapzoom, mapprojection, downloadmap, showmap, plotrun

include("run.jl")
include("io.jl")
include("metric.jl")
include("map.jl")
include("plot.jl")

end # module TrackRunning
