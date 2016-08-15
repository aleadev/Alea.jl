using Alea, FactCheck

facts("Multiindex") do

  context("multiindex()") do
    @fact multiindex(0, 4) --> zeros(1, 0)
    @fact multiindex(5, 0) --> zeros(1,5)
    @fact multiindex(1, 3) --> [0 1 2 3]'
    @fact multiindex(2, 2) --> [0 0; 0 1; 1 0; 0 2; 1 1; 2 0]
  end

  context("multiindex_order()") do
    @fact multiindex_order([0 0; 1 2; 3 5]) --> [0, 3, 8]
  end

end
