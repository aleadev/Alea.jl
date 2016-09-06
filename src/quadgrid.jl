module QuadGrid

import Iterators


function tensorise(xs::Array...)
  xs = promote(xs...)
  T = eltype(xs[1])

  m = length(xs)
  N = prod(x->length(x), xs)
  X = Array{T}(m,N)
  nk = 1
  for d=1:m
    k = 1
    rk = 0
    for i=1:N
      X[d, i] = xs[d][k]
      rk += 1
      if rk==nk
        k = k<length(xs[d]) ? k+1 : 1
        rk = 0
      end
    end
    nk = nk * length(xs[d])
  end
  X
end



tensorise_weights{T}(w::Vector{Vector{T}}) = kron(w...)
tensorise_weights(w::Vector{Any}) = begin; assert(isempty(w)); Vector(0); end

tensorise_nodes{T}(x::Vector{Vector{T}}) = tensorise(x...)
tensorise_nodes(x::Vector{Any}) = begin; assert(isempty(x)); []; end

tensorise_nodes_as_tuples{T}(x::Vector{Vector{T}}) = collect(Iterators.product(x...))
tensorise_nodes_as_tuples(x::Vector{Any}) = begin; assert(isempty(x)); []; end

tensorise_rules{T,S}(rules::Vector{Tuple{T,S}}) =
  (tensorise_nodes([r[1] for r in rules]), tensorise_weights([r[2] for r in rules]))
tensorise_rulesX(rules::Vector{Tuple{Any,Any}}) =
  ([r[1] for r in rules], [r[2] for r in rules])

export tensorise_rules
end

#(tensorise_nodes([r[1] for r in rules]), tensorise_weights([r[2] for r in rules]))

#=
w = collect(([2.0,3,4],[5,6]))
w = collect(([2.0,3,4],[5.0,6],[0.1,0.01]))
@show tensorise_weights(w)
@show tensorise_weights([])
@show tensorise_nodes(w)
@show tensorise_nodes([])

using FactCheck
using Alea

polys = [HermitePolynomials(), LegendrePolynomials(), LaguerrePolynomials(0.0)]
@show polys

rules = [Alea.gauss_rule(P, 3) for P in polys]
@show [r[1] for r in rules]
@show [r[2] for r in rules]


#@show tensorise_rulesX(rules)
@show rules[1][1]
@show rules[2][1]
@show rules[3][1]

@show collect((rules[1][1], rules[2][1], rules[3][1]))
@show [Alea.gauss_rule(P, 3)[1] for P in polys]

@show tensorise_rules(rules)
=#
