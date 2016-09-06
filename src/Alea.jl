module Alea

include("tools.jl")
include("multiindex.jl")
include("distributions.jl")
include("bases.jl")
include("quadgrid.jl")
include("gpc.jl")

using .Bases, .Multiindex, .Distributions, .QuadGrid, .GPC

export .Multiindex.*

end
