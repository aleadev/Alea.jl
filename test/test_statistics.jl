using Alea, FactCheck

facts("Distributions") do

  context("Uniform") do
    U=Uniform(0, 4)
    @fact mean(U) --> 2 "mean"
    @fact var(U) --> roughly(4//3) "variance"
  end

  @fact Statistics._dummy_func_for_code_coverage(1) --> 1

end
