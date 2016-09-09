using Alea, FactCheck

using Alea.Internal


g(x) = (x>0) ? "" : 0

facts("Tools") do

  context("@mustimplement") do
  end

  context("@returntype") do
    @fact (@returntype g(3))  --> Union{typeof(g(0)), typeof(g(1))}
  end

  context("tuple_array") do
    @fact flip_tuple_array([(1,"abc"),(2,"def")]) --> ([1, 2], ["abc", "def"])

  end
end
