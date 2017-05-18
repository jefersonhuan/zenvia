# Zenvia

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenvia-rb', '~> 0.0.11'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zenvia-rb

HTTParty is the only dependency for this gem.

## Usage

In your script

```ruby
require 'zenvia'

Zenvia.configure {|config|
    config.account = account_given_by_zenvia
    config.code = code_given_by_zenvia
    config.from = user_or_enterprise_name # optional
}

# from = personal or enterprise name. config.from is used as default.
# if you do not want to identify the sender, use from = ''
# number = area code + number / there's no need to put 55 before them
# AND format the number (i.e. remove parentheses, dashes...)
# message = body of the message

Zenvia.send_message(number, message, from = config.from)

# alternatively, you can set number parameter equal to an array of numbers
# and send the same message to them
numbers = ['DDNNNNNNNNN', 'DDNNNNNNNNM']
Zenvia.send_message(numbers, message, from = config.from)

```

That's all ;)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jefersonhuan/zenvia-rb


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

