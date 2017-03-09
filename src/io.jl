function readttwatch(file)
    data = readtable(file, header=false, skipstart=1)
    inx = unique([find(x -> isna(x), data[8]);
                  find(x -> isna(x), data[7]);
                  find(x -> isna(x), data[9]);
                  find(x -> isna(x), data[10]);
                  find(x -> isna(x), data[12])])
    deleterows!(data, inx)
    run = Run(DateTime(data[12]), data[3], data[8], data[7], data[9], data[10])
    return run
end
