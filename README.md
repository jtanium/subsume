# Subsume

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'subsume'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install subsume

## Usage

    array_of_hashes = [
        {'first_name' => 'John', 'last_name' => 'Smith'},
        {'first_name' => 'Robert', 'last_name' => 'Morehouse'},
        {'first_name' => 'John', 'last_name' => 'Lack'},
        {'first_name' => 'Mary', 'last_name' => 'Greer'},
        {'first_name' => 'John', 'last_name' => 'Morehouse'},
        {'first_name' => 'Pamela', 'last_name' => 'Smith'},
        {'first_name' => 'Mary', 'last_name' => 'Lack'},
        {'first_name' => 'Robert', 'last_name' => 'Smith'},
        {'first_name' => 'Mary', 'last_name' => 'Smith'}
    ]
    records = Subsume::Wrapper(array_of_hashes)
    records.filter('first_name' => 'Robert') #=> [{'first_name' => 'Robert', 'last_name' => 'Morehouse'}, {'first_name' => 'Robert', 'last_name' => 'Smith'}]
    records.filter('first_name' => %w(Pamela Robert)) #=> [{'first_name' => 'Robert', 'last_name' => 'Morehouse'}, {'first_name' => 'Pamela', 'last_name' => 'Smith'}, {'first_name' => 'Robert', 'last_name' => 'Smith'}]
    records.sift('first_name' => %w(John Mary)) #=> [{'first_name' => 'Robert', 'last_name' => 'Morehouse'}, {'first_name' => 'Pamela', 'last_name' => 'Smith'}, {'first_name' => 'Robert', 'last_name' => 'Smith'}]

## Contributing

1. Fork it ( https://github.com/[my-github-username]/subsume/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
