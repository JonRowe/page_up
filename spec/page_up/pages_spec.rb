require 'page_up'

describe "pagination" do
  let(:collection) { (1..12).to_a }

  it 'defaults to page 1' do
    expect(PageUp[collection].page).to eq 1
  end

  it 'defaults to 25 per page' do
    expect(PageUp[collection].per_page).to eq 25
  end

  it 'handles collections below page count' do
    expect(PageUp[collection]).to eq collection
  end

  it 'paginates collections above page count' do
    expect(PageUp[collection,1,3]).to eq [1, 2, 3]
    expect(PageUp[collection,2,3]).to eq [4, 5, 6]
    expect(PageUp[collection,3,3]).to eq [7, 8, 9]
    expect(PageUp[collection,4,3]).to eq [10, 11, 12]
  end

  it 'counts pages' do
    expect(PageUp[collection,1,5].pages).to eq 3
  end

  it 'handles no pages as 1 empty page' do
    expect(PageUp[[],1,5].pages).to eq 1
  end

  it 'exposes original size' do
    expect(PageUp[(1..100).to_a,1,5].total_size).to eq 100
  end

  it 'allows override of total size' do
    expect(PageUp[(1..10).to_a,1,5, total_size: 100].total_size).to eq 100
  end

  describe 'picking the current slice' do
    specify { expect(PageUp[[],1,1].current_slice).to eq 1..1 }
    specify { expect(PageUp[[1,2,3],1,1].current_slice).to eq 1..3 }
    specify { expect(PageUp[collection,1,1].current_slice).to eq 1..5 }
    specify { expect(PageUp[collection,2,1].current_slice).to eq 1..5 }
    specify { expect(PageUp[collection,3,1].current_slice).to eq 1..5 }
    specify { expect(PageUp[collection,4,1].current_slice).to eq 2..6 }
    specify { expect(PageUp[collection,5,1].current_slice).to eq 3..7 }
    specify { expect(PageUp[collection,6,1].current_slice).to eq 4..8 }
    specify { expect(PageUp[collection,7,1].current_slice).to eq 5..9 }
    specify { expect(PageUp[collection,8,1].current_slice).to eq 6..10 }
    specify { expect(PageUp[collection,9,1].current_slice).to eq 7..11 }
    specify { expect(PageUp[collection,10,1].current_slice).to eq 8..12 }
    specify { expect(PageUp[collection,11,1].current_slice).to eq 8..12 }
    specify { expect(PageUp[collection,12,1].current_slice).to eq 8..12 }
    specify { expect(PageUp[collection,1,5].current_slice).to eq 1..3 }
    specify { expect(PageUp[collection,2,5].current_slice).to eq 1..3 }
    specify { expect(PageUp[collection,3,5].current_slice).to eq 1..3 }
  end

end
