module Alea

include("tools.jl")
include("multiindex.jl")
include("distributions.jl")
include("bases.jl")
include("quadgrid.jl")
include("gpc.jl")

using Reexport
@reexport using .Multiindex
@reexport using .Distributions
@reexport using .Bases
@reexport using .QuadGrid
@reexport using .GPC

end
