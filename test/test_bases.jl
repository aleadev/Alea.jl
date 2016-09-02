using Alea, FactCheck

facts("OrthPoly") do
  context("ChebyshevTPolynomials") do
    polys = ChebyshevTPolynomials()
    cheb4(x) = [1, x, 2x.^2 - 1, 4x.^3 - 3x, 8x.^4 - 8x.^2 + 1]
    @fact evaluate(polys, 4, 2) --> cheb4(2)
    @fact recurrence_coeff(polys, 3) --> (0, 2, 1)
    @pending norm(polys, 3) --> 1
  end
end

import FactCheck.roughly
roughly(A::Tuple; kvtols...) = (B::Tuple) -> begin
    length(A) != length(B) && return false
    return all(a->roughly(a[1]; kvtols...)(a[2]), zip(A,B) )
end

facts("GaussIntegration") do
  @fact gauss_rule(HermitePolynomials(), 1) --> ([0.0], [1.0])
  @fact gauss_rule(HermitePolynomials(), 2) --> ([-1.0, 1.0], [0.5, 0.5])
  @fact gauss_rule(HermitePolynomials(), 3) --> roughly(([-√3, 0, √3], [1/6, 4/6, 1/6]))

  @fact gauss_rule(LegendrePolynomials(), 2) --> ([-√(1/3), √(1/3)], [0.5, 0.5])
  @fact gauss_rule(LegendrePolynomials(), 3) --> roughly(([-√(3/5), 0, √(3/5)], [5, 8, 5]/18))

  @fact gauss_rule(LaguerrePolynomials(0.0), 2) --> roughly(([2-√2, 2+√2],
                                                           [1/2+1/√8, 1/2-1/√8]))
end
