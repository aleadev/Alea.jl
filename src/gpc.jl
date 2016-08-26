using Alea
using Distributions

typealias GPCDistribution Distributions.ContinuousUnivariateDistribution

abstract GPCGerm

immutable GPCPair
  dist::GPCDistribution
  polysys::PolynomialSystem
end

immutable FixedGPCGerm <: GPCGerm
  pairs::Array{GPCPair}
end
function FixedGPCGerm(dist::GPCDistribution, n::Int)
  FixedGPCGerm(fill(dist, n))
end
length(germ::FixedGPCGerm) = length(germ.distributions)

import Base.rand
rand(germ::GPCGerm) = Float64[rand(dist) for dist=germ.distributions]

import Distributions.pdf
function pdf{T<:Real}(germ::FixedGPCGerm, x::Vector{T})
  prod([pdf(dist, xi) for (dist,xi) in zip(germ.distributions, x)])
end

import Distributions.cdf
function cdf{T<:Real}(germ::FixedGPCGerm, x::Vector{T})
  prod([cdf(dist, xi) for (dist,xi) in zip(germ.distributions, x)])
end
