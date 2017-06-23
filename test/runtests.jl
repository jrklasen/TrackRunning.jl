using TrackRunning
using Base.Test

# write your own tests here, run by: Pkg.test("TrackRunning")

try
    global hike = readttwatch("./data/hiking.csv")
  catch
      error("Failed to read 'hiking.csv'")
end

@testset "Run Tests" begin
    @test length(hike.date) == 24888
    @test length(hike.lon) == 24888
    @test length(hike.lat) == 24888
    @test length(hike.ele) == 0
    @test length(hike.lap) == 24888
    @test length(hike.hr) == 0
end

dist = distance(hike)
@testset "Distance Tests" begin
    @test length(dist) == length(hike.lon)
    @test dist[1] == 0.0
    @test dist[end] == 22047.97203642398
end
@test mapzoom(hike) == 13

mapcoor = mapprojection(hike)
@testset "MapCoordinates Tests" begin
    @test mapcoor.lon_center == -0.01981505
    @test mapcoor.lat_center == 42.6412988
    @test mapcoor.lon_left == -0.07474669062500539
    @test mapcoor.lat_top == 42.681693887264494
    @test mapcoor.lon_right == 0.035116590624994615
    @test mapcoor.lat_bottom == 42.600877469417284
    @test mapcoor.x_left == 4094.299097528889
    @test mapcoor.y_top == 3020.022953178298
    @test mapcoor.x_right == 4096.7990975288885
    @test mapcoor.y_bottom == 3022.522953178298
    @test mapcoor.zoom == 13
end

mapfile = downloadmap(mapcoor)
@test isa(mapfile, AbstractString)
