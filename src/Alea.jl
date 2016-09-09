module Alea

include("internal/Internal.jl")
include("math/Math.jl")
include("statistics/Statistics.jl")
include("bases/Bases.jl")
include("quadrature/Quadrature.jl")
include("gpc/GPC.jl")

using Reexport
@reexport using .Math
@reexport using .Statistics
@reexport using .Bases
@reexport using .Quadrature
@reexport using .GPC

end
