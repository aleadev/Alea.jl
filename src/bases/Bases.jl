"""
Implementation of different function systems for the representation of spectral
expansions. Currently, only orthogonal polynomials (for gpc) are supported.

@show recurrence_coeff(HermitePolynomials(),Array(0:3))
@show recurrence_coeff(LegendrePolynomials(),Array(0:3))
@show recurrence_coeff(ChebyshevTPolynomials(),Array(0:5))
@show recurrence_coeff(ChebyshevUPolynomials(),Array(0:5))

@show [gauss_rule(HermitePolynomials(), i) for i in 2:5]
@show [gauss_rule(LaguerrePolynomials(1.2), i) for i in 3:5]

"""
module Bases

include("orthpoly.jl")

end
