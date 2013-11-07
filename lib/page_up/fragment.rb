module PageUp
  class Fragment
    NullResult = 'NullResult'

    def initialize fragment, page, per_page, total = nil
      @page     = page
      @per_page = per_page
      @size     = total || (fragment.size + offset)
      @fragment = [].fill(NullResult, 0, offset) + fragment
    end
    attr_reader :size

    def [] range
      until covers? range
        next_page = page_for(range)
        result = @callback.call next_page, @per_page
        result.each_with_index do |value, index|
          @fragment[index + offset(next_page)] = value
        end
      end
      @fragment[range]
    end

    def use &block
      @callback = block
    end

  private

    def page_for range
      first_null = range.find { |index| @fragment.fetch(index,NullResult) == NullResult } || range.end + 1
      (first_null / @per_page) + 1
    end

    def offset page = @page
      (page - 1) * @per_page
    end

    def covers? range
      !range.any? { |index| @fragment.fetch(index,NullResult) == NullResult }
    end

  end
end
