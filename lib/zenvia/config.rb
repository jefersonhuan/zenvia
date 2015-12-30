require 'base64'
class Zenvia
  module Config
    attr_accessor :account, :code

    def self.account; @account; end

    def self.account=(account); @account = account; end

    def self.code=(code); @code = code; end

    def self.code; @code; end

    def self.name=(name); @name = name; end

    def self.name; @name; end

    private
    def self.auth; Base64.encode64("#{@account}:#{@code}").strip; end
  end
end
