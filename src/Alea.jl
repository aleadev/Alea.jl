module Alea

include("internal/Internal.jl")
include("statistics/Statistics.jl")
include("multiindex.jl")
include("bases.jl")
include("quadrature/Quadrature.jl")
include("gpc.jl")

using Reexport
@reexport using .Multiindex
@reexport using .Statistics
@reexport using .Bases
@reexport using .Quadrature
@reexport using .GPC

end
