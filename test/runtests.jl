using FactCheck
FactCheck.clear_results()
if !isdefined(:throw_on_failure)
  throw_on_failure = true
end

module PkgTests
include("tools.jl")

include("test_tools.jl")
include("test_multiindex.jl")
include("test_distributions.jl")
include("test_bases.jl")
include("test_gpc.jl")
end

if throw_on_failure
  FactCheck.exitstatus()
end
