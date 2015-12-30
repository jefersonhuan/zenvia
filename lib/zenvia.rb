class Zenvia
  def self.configure
    yield Config
  end

  def self.config
    Config
  end
end

require "zenvia/version"
require 'zenvia/config'
require 'zenvia/sms'
