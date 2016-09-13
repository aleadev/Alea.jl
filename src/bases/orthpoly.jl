using ..Internal

abstract FunctionSystem

@mustimplement evaluate{T <: Number}(basis::FunctionSystem, n::Integer, x::T)



"The base type for systems of (orthogonal) polynomials"
abstract PolynomialSystem <: FunctionSystem

@mustimplement recurrence_coeff(basis::PolynomialSystem, i::Integer)

@mustimplement issymmetric(basis::PolynomialSystem)

function rc_array(basis::PolynomialSystem, n::Integer)
  arr = [recurrence_coeff(basis, k) for k in 0:n]
  flip_tuple_array(arr)
end

function rc_array_monic(basis::PolynomialSystem, n::Integer)
  r = rc_array(basis::PolynomialSystem, n::Integer)
  # extract columns
  a = -r[1]
  b = r[3][2:end]
  c = r[2][:]

  # convert to monic polynomials
  α = a ./ c
  β = b ./ (c[1:end-1] .* c[2:end])
  return α, β
end

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

recurrence_coeff(::HermitePolynomials, k::Integer) =
  0, 1, k

issymmetric(::HermitePolynomials) = true


"The Legendre polynomials"
immutable LegendrePolynomials <: PolynomialSystem; end

recurrence_coeff(::LegendrePolynomials, k::Integer) =
  0, (2*k+1) // (k+1), k // (k+1)

issymmetric(::LegendrePolynomials) = true


"The Laguerre polynomials"
immutable LaguerrePolynomials{T<:Real} <: PolynomialSystem
  α::T
end

recurrence_coeff(L::LaguerrePolynomials, k::Integer) =
  (2k + 1 + L.α) / (k+1),
  -1 / (k+1),
  (k + L.α) / (k+1)

issymmetric(::LaguerrePolynomials) = false


immutable ChebyshevTPolynomials <: PolynomialSystem; end

recurrence_coeff(basis::ChebyshevTPolynomials, k::Integer) =
  0, (k==0 ? 1 : 2), 1

issymmetric(::ChebyshevTPolynomials) = true


immutable ChebyshevUPolynomials <: PolynomialSystem; end

recurrence_coeff(::ChebyshevUPolynomials, k::Integer) =
  0, 2, 1

issymmetric(::ChebyshevUPolynomials) = true



import Alea.Quadrature.gauss_rule
function gauss_rule(basis::PolynomialSystem, n::Integer)
  α, β = rc_array_monic(basis, n-1)

  gauss_rule((α, β))
end

export
  PolynomialSystem,
  evaluate,
  recurrence_coeff,
  issymmetric,
  HermitePolynomials,
  LegendrePolynomials,
  LaguerrePolynomials,
  ChebyshevTPolynomials,
  ChebyshevUPolynomials
