require 'page_up/pages'

module PageUp

  def self.[] collection, page = nil, per_page = nil
    PageUp::Pages.new(collection, page, per_page)
  end

end
