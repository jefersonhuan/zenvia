# Zenvia

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenvia-rb', '~> 0.0.5'
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

Zenvia.send_message(from = config.from, number, message)
```

That's all ;)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jefersonhuan/zenvia-rb


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

