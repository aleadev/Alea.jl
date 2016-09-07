using ..Multiindex
import Iterators

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

smolyak_grid(d::Integer, n::Integer) = begin
  I0 = multiindex(d, n-1) + 1
  ordI0 = multiindex_order(I0)
  ind = ordI0.>=n
  I = I0[ind, :]
  ordI = ordI0[ind]
  factor = ord_α -> ((iseven(d+n-1-ord_α) ? 1 : -1) * binomial(d-1,ord_α-n))
  factors = map(factor, ordI)
  (I, factors)
end

collect_rules(I, factors, rules) = begin
  d = size(I, 2)
  n = size(I, 1)
  #@assert d==length(rules)
  @assert n==length(factors)
  x = Matrix{Float64}(d, 0)
  w = Vector{Float64}(0)
  for i=1:n
    rule_i = rules[vec(I[i,:])]
    (x_i, w_i) = tensorise_rules(rule_i)
    x = hcat(x, x_i)
    w = vcat(w, w_i)
  end
  (x, w)
end


export
  tensorise_rules,
  smolyak_grid,
  collect_rules
