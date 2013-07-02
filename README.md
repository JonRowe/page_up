# PageUp

PageUp is a simple pagination gem, the idea being to use composition and
decoration of objects (rather than mixing into ActiveRecord) to divy up a
collection for pagination. This allows use with data sources other than ActiveRecord.

## Usage

To create a paginated collection use the `PageUp[]` macro.

`page_up_pages = PageUp[ collection, page_number, number_per_page ]`

In addition to delegating all the original collection methods back to the
underling object, a page up collection allows:

Access to the total number of pages with `pages`

`page_up_pages.pages => 3`

Access to the supplied page number with `page` (defaults to 1)

`page_up_pages.page => 2`

Access to the supplied per page count with `per_page` (defaults to 25)

`page_up_pages.per_page => 25`

And provides a range indicating the current section of pages, this is intended
for integration with output views to indicate nearby page bookmarks and as
such returns the previous two and next two pages, but is bounded so that at the
start or end of a collection always returns 5... e.g:

```
# page 2
page_up_pages.current_slice => 1..5 

# page 7
page_up_pages.current_slice => 5..9 

# page n-2
page_up_pages.current_slice => n-5..n 
```

## ToDo

Extract helpers for integration with Rails and ORM libraries.

## Installation

Add this line to your application's Gemfile:

    gem 'page_up'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install page_up

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
