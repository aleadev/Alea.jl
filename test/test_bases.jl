using Alea, FactCheck



facts("orthpoly") do
  context("ChebyshevTPolynomials") do
    polys = ChebyshevTPolynomials()
    @fact evaluate(polys, 4, 2) --> 1
    @fact recurrence_coeff(polys, 3) --> (0, 2, 1)
  end
end


#=
begin
  basis = Bases.LaguerrePolynomials(1)
  println(basis)
  println(Bases.evaluate(basis, 3, 2))
  plot(map(k->(x->Bases.evaluate(basis,k,x)[k+1]),0:7), 0, 5)
end

begin
  basis = Bases.LegendrePolynomials()
  println(basis)
  println(Bases.evaluate(basis, 3, 2))
  plot(map(k->(x->Bases.evaluate(basis,k,x)[k+1]),0:5), -1, 1)
end

begin
  basis = Bases.ChebyshevTPolynomials()
  println(basis)
  println(Bases.evaluate(basis, 3, 2))
  plot(map(k->(x->Bases.evaluate(basis,k,x)[k+1]),0:5), -1, 1)
end
=#
