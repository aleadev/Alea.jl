abstract FunctionSystem

function evaluate(basis::FunctionSystem, x::Real)
  throw
end

export evaluate

abstract PolynomialSystem <: FunctionSystem

function evaluate(basis::PolynomialSystem, n::Integer, x::Real)
  y = zeros(n+1)
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

function recurrence_coeff(basis::PolynomialSystem, i::Integer)
  throw
end


immutable LaguerrePolynomials <: PolynomialSystem
  alpha::Real
end

recurrence_coeff(basis::LaguerrePolynomials, k::Integer) =
  (2*k + 1.0 + basis.alpha) / (k+1.0),
  -1.0 / (k+1.0),
  (k + basis.alpha) / (k+1.0)



immutable LegendrePolynomials <: PolynomialSystem; end

recurrence_coeff(basis::LegendrePolynomials, k::Integer) =  0, (2*k+1.0)/(k+1.0), k / (k+1.0)



immutable ChebyshevTPolynomials <: PolynomialSystem; end

recurrence_coeff(basis::ChebyshevTPolynomials, k::Integer) = 0, 2 - (k==0), 1



immutable ChebyshevUPolynomials <: PolynomialSystem; end

recurrence_coeff(basis::ChebyshevUPolynomials, k::Integer) =  0, 2, 1+k
