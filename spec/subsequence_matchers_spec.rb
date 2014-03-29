require 'subsequence_matchers'

describe 'include_subsequence matcher' do
  include SubsequenceMatchers

  let(:array) { [1, 2, 3, 4, 5] }

  it 'matches subsequence at the start' do
    expect(array).to include_subsequence([1, 2, 3])
  end

  it 'matches subsequence at the end' do
    expect(array).to include_subsequence([3, 4, 5])
  end

  it 'matches subsequence in the middle' do
    expect(array).to include_subsequence([2, 3, 4])
  end

  it 'doesn\'t match subsequence in the wrong order' do
    expect(array).not_to include_subsequence([1, 3, 2])
  end

  it 'matches entire sequence' do
    expect(array).to include_subsequence([1, 2, 3, 4, 5])
  end

  it 'matches single-element subsequence' do
    expect(array).to include_subsequence([3])
  end

  it 'matches empty subsequence' do
    expect(array).to include_subsequence([])
  end

  context 'even when the array is empty' do
    let(:array) { [] }

    it 'matches empty subsequence' do
      expect(array).to include_subsequence([])
    end
  end

  it 'doesn\'t match a subsequence that\'s longer than the array' do
    expect(array).not_to include_subsequence([1, 2, 3, 4, 5, 6])
  end

  it 'matches multiple subsequences' do
    expect(array).to include_subsequence([1, 2, 3], [2, 3, 4], [4, 5])
  end

  it 'doesn\'t match multiple arguments if any are not subsequences' do
    expect(array).not_to include_subsequence([1, 2, 3], [2, 4, 3], [4, 5])
  end
end
