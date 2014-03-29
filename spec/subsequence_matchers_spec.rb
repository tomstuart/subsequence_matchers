require 'subsequence_matchers'

describe 'include_subsequence matcher' do
  include SubsequenceMatchers

  shared_examples 'a subsequence matcher' do
    it 'matches subsequence at the start' do
      expect(collection).to include_subsequence([1, 2, 3])
    end

    it 'matches subsequence at the end' do
      expect(collection).to include_subsequence([3, 4, 5])
    end

    it 'matches subsequence in the middle' do
      expect(collection).to include_subsequence([2, 3, 4])
    end

    it 'doesn\'t match subsequence in the wrong order' do
      expect(collection).not_to include_subsequence([1, 3, 2])
    end

    it 'matches entire collection' do
      expect(collection).to include_subsequence([1, 2, 3, 4, 5])
    end

    it 'matches single-element subsequence' do
      expect(collection).to include_subsequence([3])
    end

    it 'matches empty subsequence' do
      expect(collection).to include_subsequence([])
    end

    context 'even when the collection is empty' do
      it 'matches empty subsequence' do
        expect(empty_collection).to include_subsequence([])
      end
    end

    it 'doesn\'t match a subsequence that\'s longer than the collection' do
      expect(collection).not_to include_subsequence([1, 2, 3, 4, 5, 6])
    end

    it 'matches multiple subsequences' do
      expect(collection).to include_subsequence([1, 2, 3], [2, 3, 4], [4, 5])
    end

    it 'doesn\'t match multiple arguments if all are not subsequences' do
      expect(collection).not_to include_subsequence([1, 3, 2], [2, 4, 3], [5, 4])
    end

    it 'checks that every argument is a subsequence when not negated' do
      expect {
        expect(collection).to include_subsequence([1, 2, 3], [2, 4, 3], [4, 5])
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end

    it 'checks that every argument is not a subsequence when negated' do
      expect {
        expect(collection).not_to include_subsequence([1, 2, 3], [2, 4, 3], [4, 5])
      }.to raise_error(RSpec::Expectations::ExpectationNotMetError)
    end
  end

  context 'when the collection is an array' do
    it_should_behave_like 'a subsequence matcher' do
      let(:collection) { [1, 2, 3, 4, 5] }
      let(:empty_collection) { [] }
    end
  end

  context 'when the collection is a range' do
    it_should_behave_like 'a subsequence matcher' do
      let(:collection) { 1..5 }
      let(:empty_collection) { 1..0 }
    end
  end

  context 'when the collection is an enumerator' do
    it_should_behave_like 'a subsequence matcher' do
      let(:collection) { 1.upto(5) }
      let(:empty_collection) { 1.upto(0) }
    end
  end
end
