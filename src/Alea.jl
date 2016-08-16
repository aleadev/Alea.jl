module Alea

export
    multiindex,
    multiindex_order,

    Uniform,
    Normal,

    mean,
    var,
    skewness,
    kurtosis,
    moment,
    pdf,
    cdf,
    quantile,
    rand,

    GPCGerm,
    FixedGPCGerm

include("multiindex.jl")
include("distributions.jl")
include("gpc.jl")

end
