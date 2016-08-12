using Alea
using Base.Test

multiindex(2,5)

@test multiindex(0,4) == zeros(1,0)
@test multiindex(5,0) == zeros(1,5)
@test multiindex(1,3) == [0 1 2 3]'
@test multiindex(2,2) == [0 0; 0 1; 1 0; 0 2; 1 1; 2 0]

