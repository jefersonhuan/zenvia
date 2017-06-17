require "zenvia/version"
require 'zenvia/config'
require 'zenvia/sms'

module Zenvia
  # block of configuration
  def self.configure
    yield self.config
  end

  # alias for Zenvia::Config
  def self.config
    @config ||= Config.new
  end

  # alias for Zenvia::SMS.send_message(*args)
  def self.send_message(number, message, options = {})
    SMS.send_message number, message, options
  end

  def self.send_multiple_messages(list = [])
    SMS.send_multiple_messages list
  end

  def self.lookup(id)
    SMS.lookup id
  end
end
