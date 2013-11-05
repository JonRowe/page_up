require 'page_up/pages'
require 'page_up/fragment'

module PageUp

  def self.[] collection, page = nil, per_page = nil
    PageUp::Pages.new(collection, page, per_page)
  end

end
