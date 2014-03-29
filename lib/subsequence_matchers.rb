module SubsequenceMatchers
  extend RSpec::Matchers::DSL

  matcher :include_subsequence do |*subsequences|
    match do |array|
      subsequences.all? { |subsequence|
        subsequence.empty? || array.each_cons(subsequence.length).any?(&subsequence.method(:==))
      }
    end
  end
end
