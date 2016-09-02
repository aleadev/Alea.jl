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





  function gauss_rule(basis::PolynomialSystem, n::Integer)
  end


  #module foobar
  rc{T<:Integer}(k::Union{T,Array{T,1}}) =
    zero(k), 1+zero(k), k
  rc{T<:Integer}(k::AbstractArray{T,1}) = rc(Array{T,1}(k))
  rc(1)
  rc(3)
  rc(1:3)

  function recurrence_coeff(basis::PolynomialSystem, n::AbstractArray)
    a1,b1,c1=recurrence_coeff(basis, n[1])
    N=length(n)
    (a,b,c)=(Array{typeof(a1),1}(N), Array{typeof(b1),1}(N), Array{typeof(c1),1}(N))
    for i=1:N
      (a[i], b[i], c[i]) = recurrence_coeff(basis, n[i])
    end
    return (a,b,c)
  end


  eltypes{T1}(::Type{Tuple{T1}}) = (T1,)
  eltypes{T1,T2}(::Type{Tuple{T1,T2}}) = (T1, T2)
  eltypes{T1,T2,T3}(::Type{Tuple{T1,T2,T3}}) = (T1, T2, T3)

  function flip_tuple_array{T<:Tuple}(a::Array{T})
    types = eltypes(T)
    N = length(a)
    b = [Array{t}(N) for t in types]
    for i=1:length(types)
      for j=1:N
        b[i][j] = a[j][i]
      end
    end
    return (b...)
  end
  function recurrence_coeff2(basis::PolynomialSystem, n::AbstractArray)
    flip_tuple_array([recurrence_coeff(basis, k) for k in n])
  end

  a = [recurrence_coeff(LegendrePolynomials(), i) for i in 1:5]
  @show a
  @show typeof(a)
  @show flip_tuple_array(a)

  @show recurrence_coeff2(HermitePolynomials(),Array(0:3))
  @show recurrence_coeff(LegendrePolynomials(),Array(0:3))
  @show recurrence_coeff2(LegendrePolynomials(),Array(0:3))
  @show recurrence_coeff(ChebyshevTPolynomials(),Array(0:5))
  @show recurrence_coeff(ChebyshevUPolynomials(),Array(0:5))


#end
#
