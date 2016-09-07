using Alea, FactCheck

facts("GPC") do
  germ = GPCGerm(Normal(0,1), 4)
  #=
  @show rand(germ)
  @show pdf(germ, [0.3, 0.4, 0.5, 0.6])
  @show cdf(germ, [0.3, 0.4, 0.5, 0.6])
  @show cdf(germ, [0.0, 0.0, 0.0, 0.0])
  @show cdf(germ, [Inf, 0.0, 0.0, Inf])
  =#
  context("cdf") do
    @fact cdf(germ, zeros(4)) --> 0.5^4
    @fact cdf(germ, [0.0, 0.0, 0.0, Inf]) --> 0.5 ^ 3
    @fact cdf(germ, [0.0, -Inf, 0.0, Inf]) --> 0
  end
end
