using Alea, FactCheck

facts("tensorise") do

end

facts("smolyak") do


  (G, factors) = smolyak_grid(3, 2)
  on01 = (x::Vector{Float64},w::Vector{Float64}) -> ((x+1)/2,w)::Rule1d
  rules = [on01(gauss_rule(LegendrePolynomials(), i)...)::Rule1d for i=1:5]
  (x,w)=collect_rules(G, factors, rules)

  I=multiindex(3, 5)
  x = reshape(x, (1, size(x)...))
  II=vec(squeeze(prod(x.^I, 2), 2)*reshape(w, (size(w)...,1)))
  II2=squeeze(prod(1./(I+1),2),2)
  ex1 = BitArray{1}(map(≈,II,II2))
  ex2 = vec(sum(floor(I/2),2)).<2
  @fact ex1 --> ex2
end

#=
@show smolyak_grid(3, 4)


polys = [HermitePolynomials(), LegendrePolynomials(), LaguerrePolynomials(0.0)]
@show polys
rules = [Alea.gauss_rule(P, 3) for P in polys]
(I, factors) = smolyak_grid(3, 4)
@show collect_rules(I, factors, [Alea.gauss_rule(HermitePolynomials(), i) for i=1:4])

(I, factors) = smolyak_grid(2, 7)
@show collect_rules(I, factors, [Alea.gauss_rule(HermitePolynomials(), i) for i=1:7])
=#


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
