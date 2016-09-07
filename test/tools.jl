import FactCheck.roughly
roughly(A::Tuple; kvtols...) = (B::Tuple) -> begin
    length(A) != length(B) && return false
    return all(a->roughly(a[1]; kvtols...)(a[2]), zip(A,B) )
end
