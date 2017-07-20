using TrackRunning
using Base.Test

# write your own tests here, run by: Pkg.test("TrackRunning")

try
    global hike = readrun(joinpath(Pkg.dir("TrackRunning"),
        "example", "data", "hiking.csv"))
  catch
    error("Failed to read 'hiking.csv'")
end

@testset "Run Tests" begin
    @test length(hike) == 24673
    @test length(hike.date) == 24673
    @test length(hike.lon) == 24673
    @test length(hike.lat) == 24673
    @test length(hike.ele) == 0
    @test length(hike.lap) == 24673
    @test length(hike.hr) == 0

    @test hike[end].date == [DateTime("2016-10-16T17:55:05")]
    @test hike[(end-1):end].date == [DateTime("2016-10-16T17:55:04"); 
                                     DateTime("2016-10-16T17:55:05")]
    
    @test start(hike) == 1
    @test next(hike, 1)[2] == 2
    @test done(hike, length(hike)) == false                      
    @test done(hike, length(hike) + 1) == true
end

sec = time_sec(hike)
@testset "Time Tests" begin
    @test length(sec) == length(hike.lon) - 1
    @test sec[1] ≈ 1.0
    @test sec[end] ≈ 24678.0
end

m = dist_m(hike)
@testset "Distance Tests" begin
    @test length(m) == length(hike.lon) - 1
    @test m[1] ≈ 1.2038457030465493
    @test m[end] ≈ 21865.947388700704
end

kmh = speed_kmh(hike)
@testset "Speed Tests" begin
    @test length(kmh) == length(hike.lon) - 1
    @test kmh[1] ≈ 4.3338445309675775
    @test kmh[end] ≈ 0.0
end

minkm = pace_minkm(hike)
@testset "Pace Tests" begin
    @test length(minkm) == length(hike.lon) - 1
    @test minkm[1] ≈ 13.844520626263526
    @test minkm[end] ≈ Inf
end

@test mapzoom(hike) == 13

mapcoor = mapprojection(hike)
@testset "MapCoordinates Tests" begin
    @test mapcoor.lon_center ≈ -0.01981505
    @test mapcoor.lat_center ≈ 42.6412988
    @test mapcoor.lon_left ≈ -0.07474669062500539
    @test mapcoor.lat_top ≈ 42.681693887264494
    @test mapcoor.lon_right ≈ 0.035116590624994615
    @test mapcoor.lat_bottom ≈ 42.600877469417284
    @test mapcoor.x_left ≈ 4094.299097528889
    @test mapcoor.y_top ≈ 3020.022953178298
    @test mapcoor.x_right ≈ 4096.7990975288885
    @test mapcoor.y_bottom ≈ 3022.522953178298
    @test mapcoor.zoom ≈ 13
end

mapfile = downloadmap(mapcoor)
@test isa(mapfile, AbstractString)
