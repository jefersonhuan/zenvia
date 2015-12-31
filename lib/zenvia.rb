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
  def self.send_message(from = nil, number, message)
    SMS.send_message(from, number, message)
  end
end
