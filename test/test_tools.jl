using Alea, FactCheck

using Alea.Internal


g(x) = (x>0) ? "" : 0

facts("Tools") do

  context("@mustimplement") do
  end

  context("@returntype") do
    @fact (@returntype g(3))  --> Union{ASCIIString, Int64}
  end

end
