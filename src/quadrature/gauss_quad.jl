function gauss_rule{S<:Real,T<:Real}(monic_rc::Tuple{Vector{S}, Vector{T}})
  # W. GAUTSCHI, ORTHOGONAL POLYNOMIALS AND QUADRATURE, Electronic
  # Transactions on Numerical Analysis, Volume 9, 1999, pp. 65-76.

  α = monic_rc[1]
  β = monic_rc[2]
  # set up Jacobi matrix and compute eigenvalues
  J = SymTridiagonal(α, √β)
  #J = float(diagm(α) + diagm(√β,1) + diagm(√β,-1))
  x, V = eig(J)
  w = vec(V[1,:]'.^2)
  w = w / sum(w);

  # symmetrise
  if all(α==0)
      x=0.5*(x-reverse(x));
      w=0.5*(w+reverse(w));
  end
  return (x::Vector{Float64},w::Vector{Float64})
end

export gauss_rule
