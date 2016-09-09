#typealias MultiindexSet{T} Array{T}
#typ MultiindexSet{T} <: AbstractArray{T, 2}

function multiindex{T<:Integer}(m::Integer,p::T)
    if m==0
        I = zeros(T,1,0)
        return I
    end
    I = zeros(T,0,m)
    I1 = multiindex(m-1, p)
    ord = reshape(sum(I1,2), size(I1,1))
    for q=0:p
        ind=map(o -> (o<=q), ord)
        n=sum(ind)
        Iq = [I1[ind,:] (q-sum(I1[ind,:],2))]
        I = [I; Iq]
    end
    return I
end

function multiindex_order{T<:Integer}(I::AbstractArray{T})
  return vec(sum(I,2))
end

export
    multiindex,
    multiindex_order
