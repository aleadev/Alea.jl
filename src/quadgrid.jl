module ArraySlices

import Base: length, size, eltype, getindex

export slices, columns, rows

# Type parameters
#
# F : type of SubArray
# D : indexed dimension of the array
# A : array type
#
immutable SliceIterator{F, D, A<:AbstractArray} <: AbstractVector{F}
    array::A
end

# ensure compatibility between versions
if VERSION < v"0.5-dev"
    _get_L(D, N) = D == 1 ? N : D
else
    _get_L(D, N) = D == 1 || D == N ? true : false
end

"""
    slices(array, dim)
Return a `SliceIterator` object to loop over the slices of `array` along
dimension `dim`.
"""
@generated function slices{T, N, D}(array::AbstractArray{T, N}, ::Type{Val{D}})
    # checks
    1 <= D <= N || error("invalid slice dimension")

    # construct incomplete type of slice, then fill
    # example: SubArray{Float64, 1, Array{Float64,2}, Tuple{Int64, Colon}, true}
    F = :(SubArray{$T, $(N-1), $array})

    # construct tuple of indices
    tupexpr = :(Tuple{})
    for i = 1:N
        push!(tupexpr.args, :Colon)
    end
    tupexpr.args[1+D] = :Int
    push!(F.args, tupexpr)

    # add L/LD parameter
    push!(F.args, _get_L(D, N))

    # build and return iterator
    :(SliceIterator{$F, $D, $array}(array))
end

# ~~~ Array interface ~~~
eltype{F}(s::SliceIterator{F}) = F
length{F, D}(s::SliceIterator{F, D}) = size(s.array, D)
size(s::SliceIterator) = (length(s), )

# build code that produces slices with the correct indexing
@generated function getindex{F, D}(s::SliceIterator{F, D}, i::Integer)
    # get ndims of parent array
    N = s.parameters[1].parameters[3].parameters[2]
    expr = :()
    expr.head = :call
    push!(expr.args, :slice)
    push!(expr.args, :(getfield(s, :array)))
    # fill in with `Colon`s
    for i = 1:N
        push!(expr.args, Colon())
    end
    # then replace the indexed dimension
    expr.args[2 + D] = :i
    expr
end



# ~~~ Convenience functions for 2D arrays ~~~

"""
    columns(array)
Return a `SliceIterator` object to loop over the columns of `array`.
"""
columns(array::AbstractMatrix) = slices(array, Val{2})

"""
    rows(array)
Return a `SliceIterator` object to loop over the rows of `array`.
"""
rows(array::AbstractMatrix) = slices(array, Val{1})

end


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

using ..Multiindex
using ..ArraySlices
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

end

module fooo
using ..QuadGrid
@show smolyak_grid(3, 4)


using Alea
polys = [HermitePolynomials(), LegendrePolynomials(), LaguerrePolynomials(0.0)]
@show polys
rules = [Alea.gauss_rule(P, 3) for P in polys]
(I, factors) = smolyak_grid(3, 4)
@show collect_rules(I, factors, [Alea.gauss_rule(HermitePolynomials(), i) for i=1:4])

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
