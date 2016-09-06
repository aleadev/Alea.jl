module Distributions

using Distributions

export
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
    rand

end
