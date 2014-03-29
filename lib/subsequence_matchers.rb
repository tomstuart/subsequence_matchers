module SubsequenceMatchers
  extend RSpec::Matchers::DSL

  matcher :include_subsequence do |*subsequences|
    match do |collection|
      perform_match(collection, subsequences, :all?)
    end

    match_when_negated do |collection|
      perform_match(collection, subsequences, :none?)
    end

    private

    def perform_match(collection, subsequences, predicate)
      subsequences.send(predicate) { |subsequence| subsequence?(collection, subsequence) }
    end

    def subsequence?(collection, subsequence)
      subsequence.empty? || collection.each_cons(subsequence.length).include?(subsequence)
    end
  end
end
