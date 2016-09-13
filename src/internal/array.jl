function tensorise(xs::Array...)
  xs = promote(xs...)
  T = eltype(xs[1])

  m = length(xs)
  N = prod(x->length(x), xs)
  X = Array{T}(m,N)
  nk = 1
  for d=1:m
    k = 1
    rk = 0
    for i=1:N
      X[d, i] = xs[d][k]
      rk += 1
      if rk==nk
        k = k<length(xs[d]) ? k+1 : 1
        rk = 0
      end
    end
    nk = nk * length(xs[d])
  end
  X
end

colvec{T}(x::Vector{T}) = reshape(x, (length(x), 1))::Matrix{T}
rowvec{T}(x::Vector{T}) = reshape(x, (1, length(x)))::Matrix{T}

export
  tensorise,
  colvec,
  rowvec
