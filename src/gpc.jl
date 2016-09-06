module GPC

using ..Distributions
using ..Bases

typealias GPCDistribution Distributions.ContinuousUnivariateDistribution

"A gpc pair, capturing the pairing of distributions with systems of orthogonal polymials"
immutable GPCPair
  dist::GPCDistribution
  polysys::PolynomialSystem
end

"The standard mapping from distribution to orthogonal polynomials"
map_dist_to_polysys = Dict{GPCDistribution, PolynomialSystem}()
map_dist_to_polysys[Uniform(-1,1)] = LegendrePolynomials()
map_dist_to_polysys[Normal(0,1)] = HermitePolynomials()

"Constructor for GPCPairs "
GPCPair(dist) = GPCPair(dist, map_dist_to_polysys[dist])

"The abstract base for gpc germs (maybe we extend that later to infinite germs)"
abstract GPCGermBase


"A gpc germ of fixed length (the standard case)"
immutable GPCGerm <: GPCGermBase
  pairs::Array{GPCPair}
end
function GPCGerm(dist::GPCDistribution, n::Int)
  GPCGerm(fill(GPCPair(dist), n))
end

import Base.length
length(germ::GPCGerm) = length(germ.pairs)

distributions(germ::GPCGerm) = [pair.dist for pair in germ.pairs]

import Base.rand
rand(germ::GPCGerm) = Float64[rand(dist) for dist=distributions(germ)]

import Distributions.pdf
function pdf{T<:Real}(germ::GPCGerm, x::Vector{T})
  prod([pdf(dist, xi) for (dist,xi) in zip(distributions(germ), x)])
end

import Distributions.cdf
function cdf{T<:Real}(germ::GPCGerm, x::Vector{T})
  prod([cdf(dist, xi) for (dist,xi) in zip(distributions(germ), x)])
end

end
