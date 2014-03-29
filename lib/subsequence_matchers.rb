module SubsequenceMatchers
  extend RSpec::Matchers::DSL

  matcher :include_subsequence do |*subsequences|
    match do |array|
      perform_match(array, subsequences, :all?)
    end

    match_when_negated do |array|
      perform_match(array, subsequences, :none?)
    end

    private

    def perform_match(array, subsequences, predicate)
      subsequences.send(predicate) { |subsequence| subsequence?(array, subsequence) }
    end

    def subsequence?(array, subsequence)
      subsequence.empty? || array.each_cons(subsequence.length).any?(&subsequence.method(:==))
    end
  end
end
