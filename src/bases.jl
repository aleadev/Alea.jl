using .Internal

abstract FunctionSystem

@mustimplement evaluate{T <: Number}(basis::FunctionSystem, n::Integer, x::T)
export evaluate



"The base type for systems of (orthogonal) polynomials"
abstract PolynomialSystem <: FunctionSystem
export PolynomialSystem

@mustimplement recurrence_coeff(basis::PolynomialSystem, i::Integer)
export recurrence_coeff

@mustimplement issymmetric(basis::PolynomialSystem)
export issymmetric

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
export HermitePolynomials

recurrence_coeff(::HermitePolynomials, k::Integer) =
  0, 1, k

issymmetric(::HermitePolynomials) = true


"The Legendre polynomials"
immutable LegendrePolynomials <: PolynomialSystem; end
export LegendrePolynomials

recurrence_coeff(::LegendrePolynomials, k::Integer) =
  0, (2*k+1) // (k+1), k // (k+1)

issymmetric(::LegendrePolynomials) = true


"The Laguerre polynomials"
immutable LaguerrePolynomials{T<:Real} <: PolynomialSystem
  α::T
end
export LaguerrePolynomials

recurrence_coeff(L::LaguerrePolynomials, k::Integer) =
  (2k + 1 + L.α) / (k+1),
  -1 / (k+1),
  (k + L.α) / (k+1)

issymmetric(::LaguerrePolynomials) = false


immutable ChebyshevTPolynomials <: PolynomialSystem; end
export ChebyshevTPolynomials

recurrence_coeff(basis::ChebyshevTPolynomials, k::Integer) =
  0, (k==0 ? 1 : 2), 1

issymmetric(::ChebyshevTPolynomials) = true


immutable ChebyshevUPolynomials <: PolynomialSystem; end
export ChebyshevUPolynomials

recurrence_coeff(::ChebyshevUPolynomials, k::Integer) =
  0, 2, 1

issymmetric(::ChebyshevUPolynomials) = true




function gauss_rule(basis::PolynomialSystem, n::Integer)
  # W. GAUTSCHI, ORTHOGONAL POLYNOMIALS AND QUADRATURE, Electronic
  # Transactions on Numerical Analysis, Volume 9, 1999, pp. 65-76.

  α, β = rc_array_monic(basis, n-1)

  # set up Jacobi matrix and compute eigenvalues
  J = float(diagm(α) + diagm(√β,1) + diagm(√β,-1))
  x, V = eig(J)
  w = vec(V[1,:]'.^2)
  w = w / sum(w);

  # symmetrise
  if issymmetric(basis)
      x=0.5*(x-reverse(x));
      w=0.5*(w+reverse(w));
  end
  return (x::Vector{Float64},w::Vector{Float64})
end
export gauss_rule

#=
@show typeof([recurrence_coeff(LaguerrePolynomials(1.2),i) for  i in []])
@show typeof([recurrence_coeff(HermitePolynomials(),i) for  i in []])
@show typeof([recurrence_coeff(HermitePolynomials(),i) for  i in [1,2,3]])
@show [gauss_rule(HermitePolynomials(), i) for i in 2:5]
@show [gauss_rule(LaguerrePolynomials(1.2), i) for i in 3:5]


a = [recurrence_coeff(LegendrePolynomials(), i) for i in 1:5]
@show a
@show typeof(a)
@show flip_tuple_array(a)

@show recurrence_coeff(HermitePolynomials(),Array(0:3))
@show recurrence_coeff(LegendrePolynomials(),Array(0:3))
@show recurrence_coeff(ChebyshevTPolynomials(),Array(0:5))
@show recurrence_coeff(ChebyshevUPolynomials(),Array(0:5))
=#
