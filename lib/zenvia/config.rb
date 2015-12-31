require 'base64'
module Zenvia
  class Config
    attr_accessor :account, :code, :from

    private
    def self.auth; Base64.encode64("#{@account}:#{@code}").strip; end
  end
end
