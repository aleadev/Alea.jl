using QuadGrid
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
