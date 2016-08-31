using Alea, FactCheck

facts("OrthPoly") do
  context("ChebyshevTPolynomials") do
    polys = ChebyshevTPolynomials()
    cheb4(x) = [1, x, 2x.^2 - 1, 4x.^3 - 3x, 8x.^4 - 8x.^2 + 1]
    @fact evaluate(polys, 4, 2) --> cheb4(2)
    @fact recurrence_coeff(polys, 3) --> (0, 2, 1)
    @pending norm(polys, 3) --> 4
  end
end
