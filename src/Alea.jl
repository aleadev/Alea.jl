module Alea

export
    multiindex,
    multiindex_order,

#=
    FunctionSystem,
    PolynomialSystem,
    HermitePolynomials,
    LegendrePolynomials,
    LaguerrePolynomials,
    ChebyshevTPolynomials,
    ChebyshevUPolynomials,
=#
    recurrence_coeff,
    evaluate,


    Distribution,
    UnivariateDistribution,
    ContinuousUnivariateDistribution,

    Uniform,
    Normal,
    Arcsine,
    Exponential,
    Beta,
    Gamma,
    InverseGamma,

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
include("bases.jl")
include("gpc.jl")

end
