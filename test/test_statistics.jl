using Alea, FactCheck

facts("Distributions") do

  context("Uniform") do
    U=Uniform(0, 4)
    @fact mean(U) --> 2 "mean"
    @fact var(U) --> roughly(4//3) "variance"
  end

end
