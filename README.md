# Zenvia

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zenvia-rb', '~> 0.0.2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zenvia-rb

HTTParty is the only dependency for this gem.

## Usage

### Configuration
In your script
```ruby

Zenvia.configure {|config|
    config.account = account_given_by_zenvia
    config.code = code_given_by_zenvia
    config.name = user_or_enterprise_name # optional
}

```

### Usage
```ruby
require 'zenvia'

# if from is nil, the sender name will be set as config.name (as above)
# if you prefer a definitely nil sender, you can set from = ''

sms = Zenvia::SMS.new(from, number, message)
sms.send_message
```

That's all ;)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jefersonhuan/zenvia-rb


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

