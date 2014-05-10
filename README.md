# Frontend::Helpers

Useful Ruby utilities for creating web UIs. Use in conjunction with [frontend-assets](https://github.com/moneyadviceservice/frontend-assets)

## Installation

Add this line to your application's Gemfile:

    gem 'frontend-helpers'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install frontend-helpers

## Usage

Utilities provided by this gem (see the specs for full details):

### Validation
#### `Frontend::Helpers::Validation::OrderedErrors`
- An enumeration over an ActiveModel::Errors object, which yields full error messages for each field, in the field order specified on the constructor
- Provides an `#each_for(field_name)` method, that yields the specified field's full error messages, along with the index of each field from the overall error list

## Contributing

1. Fork it ( https://github.com/moneyadviceservice/frontend-helpers/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
