"""
    `readrun(file)` reading running data.
"""
function readrun(file)
    data = readtable(file, header=false)
    inx = unique([find(x -> isna(x), data[1]);
                  find(x -> isna(x), data[2]);
                  find(x -> isna(x), data[3])])
    deleterows!(data, inx)
    date = DateTime(data[1])
    if length(find(x -> isna(x), data[4])) == 0
        ele = data[4]
    else
        ele = Vector{AbstractFloat}[]
    end
    if length(find(x -> isna(x), data[5])) == 0
        lap = data[5]
    else
        lap = Vector{Integer}[]
    end
    if length(find(x -> isna(x), data[6])) == 0
        hr = data[6]
    else
        hr = Vector{Integer}[]
    end
    run = Run(date, data[2], data[3], ele, lap, hr)
    return run
end

"""
    `readttwatch(file)` reading csv-data generated by ttwatch.

See: https://github.com/ryanbinns/ttwatch
"""
function readttwatch(file)
    data = readtable(file, header=false, skipstart=1)
    inx = unique([find(x -> isna(x), data[12]);
                  find(x -> isna(x), data[8]);
                  find(x -> isna(x), data[7])])
    deleterows!(data, inx)
    date = DateTime(data[12])
    if length(find(x -> isna(x), data[3])) == 0
        lap = data[3]
    else
        lap = Vector{Integer}[]
    end
    if length(find(x -> isna(x), data[9])) == 0
        ele = data[9]
    else
        ele = Vector{AbstractFloat}[]
    end
    if length(find(x -> isna(x), data[10])) == 0
        hr = data[10]
    else
        hr = Vector{Integer}[]
    end
    run = Run(lap, date, data[8], data[7], ele, hr)
    return run
end
