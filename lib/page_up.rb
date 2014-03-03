require 'page_up/pages'
require 'page_up/fragment'

module PageUp

  def self.[] collection, page = nil, per_page = nil, opts = {}
    PageUp::Pages.new(collection, page, per_page, opts)
  end

end
