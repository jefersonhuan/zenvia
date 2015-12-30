require 'base64'
module Zenvia
  class Config
    attr_accessor :account, :code, :name

    def self.account; @account; end

    def self.account=(account); @account = account; end

    def self.code=(code); @code = code; end

    def self.code; @code; end

    def self.from=(from); @from = from; end

    def self.from; @from; end

    private
    def self.auth; Base64.encode64("#{@account}:#{@code}").strip; end
  end
end
