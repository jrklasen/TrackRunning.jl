# TrackRunning

Linux & MacOS:
[![Build Status](https://travis-ci.org/jrklasen/TrackRunning.jl.svg?branch=master)](https://travis-ci.org/jrklasen/TrackRunning.jl)
and Windows:
[![Build status](https://ci.appveyor.com/api/projects/status/4iqftaeavygayts2?svg=true)](https://ci.appveyor.com/project/jrklasen/trackrunning-jl)

Test coverage:
[![codecov.io](http://codecov.io/github/jrklasen/TrackRunning.jl/coverage.svg?branch=master)](http://codecov.io/github/jrklasen/TrackRunning.jl?branch=master)

Creating this package had mainly the aim of working with Julia. Analyzing and visualizing
running-data is simply a means to an end.

### Hiking in Spain
```julia
using TrackRunning

hike = readrun(joinpath(Pkg.dir("TrackRunning"),
    "example", "data", "hiking.csv"))

f = figure(figsize = (10, 10), dpi = 300)
showmap(hike, maptype = "hybrid")
plotrun(hike, s = .01)
```

![hiking](https://github.com/jrklasen/TrackRunning.jl/blob/dev/example/plot/hiking.png?raw=true)
