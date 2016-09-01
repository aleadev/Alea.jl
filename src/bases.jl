using .Internal

abstract FunctionSystem

@mustimplement evaluate{T <: Number}(basis::FunctionSystem, n::Integer, x::T)
export evaluate



"The base type for systems of (orthogonal) polynomials"
abstract PolynomialSystem <: FunctionSystem
export PolynomialSystem

@mustimplement recurrence_coeff(basis::PolynomialSystem, i::Integer)
export recurrence_coeff

"Evaluate polynomials at `x` up to degree `n-1`"
function evaluate{T <: Number}(basis::PolynomialSystem, n::Integer, x::T)
  y = zeros(T, n+1)
  y[1] = 1
  for k=0:n-1
    a, b, c = recurrence_coeff(basis, k)
    y[k+2] = (a + b * x) * y[k+1]
    if k>0
      y[k+2] = y[k+2] - c * y[k]
    end
  end
  return y
end


"The stochastic Hermite polynomials"
immutable HermitePolynomials <: PolynomialSystem; end
export HermitePolynomials

recurrence_coeff(basis::HermitePolynomials, k::Integer) =
  0, 1, k


"The Laguerre polynomials"
immutable LaguerrePolynomials <: PolynomialSystem
  α::Real
end
export LaguerrePolynomials

recurrence_coeff(L::LaguerrePolynomials, k::Integer) =
  (2k + 1 + L.α) / (k+1),
  -1 / (k+1),
  (k + L.α) / (k+1)



immutable LegendrePolynomials <: PolynomialSystem; end
export LegendrePolynomials

recurrence_coeff(basis::LegendrePolynomials, k::Integer) =
  0, (2*k+1) // (k+1), k // (k+1)



immutable ChebyshevTPolynomials <: PolynomialSystem; end
export ChebyshevTPolynomials

recurrence_coeff(basis::ChebyshevTPolynomials, k::Integer) =
  0, 2 - (k==0), 1



immutable ChebyshevUPolynomials <: PolynomialSystem; end
export ChebyshevUPolynomials

recurrence_coeff(basis::ChebyshevUPolynomials, k::Integer) =
  0, 2, 1

