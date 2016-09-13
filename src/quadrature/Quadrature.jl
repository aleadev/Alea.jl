module Quadrature

typealias Rule1d Tuple{Vector{Float64}, Vector{Float64}}

include("gauss_quad.jl")
include("quadgrid.jl")

export Rule1d
end
