require 'page_up/fragment'

describe 'fragmented pages' do
  let(:source)   { ( 1..100).to_a }
  let(:fragment) { (21..40 ).to_a }
  let(:pages)    { PageUp::Fragment.new fragment, 2, 20 }

  it 'guesses the size based on fragment and page number' do
    expect(pages.size).to eq 40
  end
  it 'can be configured to take a size' do
    expect(PageUp::Fragment.new([], 2, 20, 60).size).to eq 60
  end

  context 'when the range requested is within the fragment' do
    it 'returns the local results' do
      expect(pages[20...40]).to eq fragment
    end
  end

  context 'when the range is outside the fragment' do
    let(:pages_requested) { [] }
    let(:pages) { PageUp::Fragment.new fragment, 2, 20, source.size }

    before do
      pages.use do |page, per_page|
        pages_requested << [page, per_page]
        source.slice (page -1)* per_page, per_page
      end
    end

    it 'will call the block supplied to use with page and the amount per page' do
      pages[40...60]
      expect(pages_requested).to eq [[3,20]]
    end

    it 'will call the block with only the desired pages' do
      pages[60...80]
      expect(pages_requested).to eq [[4,20]]
    end

    it 'will retrieve earlier results if it has to' do
      expect(pages[0...20]).to eq (1..20).to_a
    end

    it 'will call the block multiple times if required' do
      pages[70...90]
      expect(pages_requested).to eq [[4,20],[5,20]]
    end

    it 'will return the desired fragment' do
      expect(pages[70...90]).to eq (71..90).to_a
    end

    it 'will collect all results if necessary' do
      expect(pages.to_a).to eq source
    end

    it 'protects against ranges that exceed the existing data' do
      Timeout.timeout(0.3) do
        expect(pages[90...110]).to eq (91..100).to_a
      end
    end
  end

end
