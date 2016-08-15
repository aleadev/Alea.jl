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
    rand

include("multiindex.jl")
include("distributions.jl")

end
