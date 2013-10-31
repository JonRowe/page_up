module PageUp
  class Pages < SimpleDelegator

    def initialize collection, page, per_page
      @page     = parse page, 1
      @per_page = parse per_page, 25
      @origin   = collection
      super collection[page_range]
    end

    def total_size
      @origin.size
    end

    def pages
      if @origin.size > 0
        (@origin.size.to_f / per_page).ceil
      else
        1
      end
    end

    def current_slice
      slice_start..slice_end
    end

    attr_reader :page, :per_page

  private

    def page_range
      current_page...current_page+per_page
    end

    def current_page
      (page-1)*per_page
    end

    def parse value, default
      Integer(value)
    rescue TypeError
      default
    end

    def slice_start
      if page - 2 <= 0
        1
      elsif page + 2 > pages
        pages - 4
      else
        page - 2
      end
    end

    def slice_end
      if page + 2 > pages || pages < 5
        pages
      elsif page - 2 <= 0
        5
      else
        page + 2
      end
    end

  end
end
