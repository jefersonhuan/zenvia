require "zenvia/version"
require 'zenvia/config'
require 'zenvia/sms'

module Zenvia
  # block of configuration
  def self.configure
    yield self.config
  end

  def self.config
    Config
  end
end
