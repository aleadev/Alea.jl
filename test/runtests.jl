using FactCheck
FactCheck.clear_results()
if !isdefined(:throw_on_failure)
  throw_on_failure = true
end

module PkgTests
include("tools.jl")

include("test_internal.jl")
include("test_math.jl")
include("test_statistics.jl")
include("test_bases.jl")
include("test_quadrature.jl")
include("test_gpc.jl")
end

if throw_on_failure
  FactCheck.exitstatus()
end
