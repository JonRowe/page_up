require 'page_up/fragment'

describe 'fragmented pages' do
  let(:source)   { ( 1..100).to_a }
  let(:fragment) { (21..40 ).to_a }
  let(:pages)    { PageUp::Fragment.new fragment, 2, 20 }

  context 'when the range requested is within the fragment' do
    it 'returns the local results' do
      expect(pages[20...40]).to eq fragment
    end
  end

  context 'when the range is outside the fragment' do
    let(:pages_requested) { [] }

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

    it 'will call the block multiple times if required' do
      pages[70...90]
      expect(pages_requested).to eq [[4,20],[5,20]]
    end

    it 'will return the desired fragment' do
      expect(pages[70...90]).to eq (71..90).to_a
    end
  end

end
