using FactCheck
FactCheck.clear_results()
if !isdefined(:throw_on_failure)
  throw_on_failure = true
end

module PkgTests
include("test_multiindex.jl")
include("test_distributions.jl")
end

if throw_on_failure
  FactCheck.exitstatus()
end
