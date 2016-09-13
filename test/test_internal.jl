using Alea, FactCheck

using Alea.Internal


g(x) = (x>0) ? "" : 0

facts("base") do

  context("@mustimplement") do
  end

  context("@returntype") do
    @fact (@returntype g(3))  --> Union{typeof(g(0)), typeof(g(1))}
  end

  context("tuple_array") do
    @fact flip_tuple_array([(1,"abc"),(2,"def")]) --> ([1, 2], ["abc", "def"])

  end
end

facts("array_slice") do
  A = [1 2 3; 4 5 6];
  @fact [(i, copy(r)) for (i,r) in enumerate(rows(A))] --> [(1,[1,2,3]), (2,[4,5,6])]
  @fact [(i, copy(c)) for (i,c) in enumerate(columns(A))] --> [(1,[1,4]), (2,[2,5]), (3,[3,6])]
end

facts("array") do
  @fact rowvec([1.0, 2.0]) --> [1.0 2.0]
  @fact colvec([1.0, 2.0]) --> [1.0 2.0]'

  @fact tensorise([1,2,3], [4,5], [6 7 8]) --> [
    1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3
    4 4 4 5 5 5 4 4 4 5 5 5 4 4 4 5 5 5
    6 6 6 6 6 6 7 7 7 7 7 7 8 8 8 8 8 8
  ]
end
