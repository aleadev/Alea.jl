using Distributions


_dummy_func_for_code_coverage(x) = x

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
