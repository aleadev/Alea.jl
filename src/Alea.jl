module Alea

export
    multiindex,
    multiindex_order,

    ChebyshevTPolynomials,
    ChebyshevUPolynomials,

    recurrence_coeff,
    evaluate,


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
include("bases.jl")

end
