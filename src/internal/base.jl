macro mustimplement(sig)
    fname = sig.args[1]
    arg1 = sig.args[2]
    if isa(arg1,Expr)
        arg1 = arg1.args[1]
    end
    :($(esc(sig)) = error(typeof($(esc(arg1))),
                          " must implement ", $(Expr(:quote,fname))))
end
export @mustimplement

macro returntype(expr)
  esc(:(eltype([$expr for i in []])))
end
export @returntype

eltypes{T1}(::Type{Tuple{T1}}) = (T1,)
eltypes{T1,T2}(::Type{Tuple{T1,T2}}) = (T1, T2)
eltypes{T1,T2,T3}(::Type{Tuple{T1,T2,T3}}) = (T1, T2, T3)
eltypes{T1,T2,T3,T4}(::Type{Tuple{T1,T2,T3,T4}}) = (T1, T2, T3, T4)

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
export flip_tuple_array
