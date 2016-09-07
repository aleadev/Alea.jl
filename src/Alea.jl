module Alea

include("internal/Internal.jl")
include("multiindex.jl")
include("distributions.jl")
include("bases.jl")
include("quadrature/Quadrature.jl")
include("gpc.jl")

using Reexport
@reexport using .Multiindex
@reexport using .Distributions
@reexport using .Bases
@reexport using .Quadrature
@reexport using .GPC

end
