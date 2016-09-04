import Iterators

tensorise_weights{T}(w::Vector{Vector{T}}) = kron(w...)
tensorise_weights(w::Vector{Any}) = begin; assert(isempty(w)); Vector(0); end

tensorise_nodes{T}(x::Vector{Vector{T}}) = collect(Iterators.product(x...))
tensorise_nodes(x::Vector{Any}) = begin; assert(isempty(x)); []; end



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



tensorise_rules(rules::Vector{Tuple{Any,Any}}) =
  ([r[1] for r in rules], [r[2] for r in rules])
#(tensorise_nodes([r[1] for r in rules]), tensorise_weights([r[2] for r in rules]))

@show tensorise_rules(rules)
