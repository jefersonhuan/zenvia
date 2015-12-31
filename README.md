# Zenvia

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenvia-rb', '~> 0.0.7'
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

# from = personal or enterprise name. config.from will be used as default.
# if you do not want to identify the sender, use from = ''
# number = area code + number / there's no need to put 55 before them.
# It's automatically added
# message = body of the message

Zenvia.send_message(from = config.from, number, message)

# alternatively, you can set number parameter equal to an array of numbers - and send the same message to them
numbers = ['DDNNNNNNNNN', 'DDNNNNNNNNM']
Zenvia.send_message(from = config.from, numbers, message)

```

That's all ;)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jefersonhuan/zenvia-rb


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

