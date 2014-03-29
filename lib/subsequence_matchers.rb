module SubsequenceMatchers
  extend RSpec::Matchers::DSL

  matcher :include_subsequence do |subsequence|
    match do |array|
      subsequence.empty? || array.each_cons(subsequence.length).any?(&subsequence.method(:==))
    end
  end
end
