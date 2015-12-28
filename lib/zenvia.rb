require "zenvia/version"
require 'httparty'
require 'base64'
require 'json'

class Zenvia
  def initialize(user, code)
    return puts 'User and code must no be nil' if user.nil? or code.nil?
    @auth = Base64.encode64("#{user}:#{code}").strip
  end

  attr_writer :auth

  def send_message(from = nil, to, message)
    return puts 'The receiver must not be nil' if to.nil?
    to = to.to_s unless to.class.eql? String
    return puts 'The to-number must have just numbers!' unless /\d*/.match(to)
    response = send_sms(from, to, message)
    print 'JSON response: ' + response.body
  end

  private
  def send_sms(from = nil, to, message)
    to.insert(0, '55') unless /^55/.match(to)
    endpoint = 'https://api-rest.zenvia360.com.br/services/send-sms'
    HTTParty.post(endpoint,
                  body: {
                      sendSmsRequest: {
                          from: from,
                          to: to,
                          schedule: Time.now.utc.iso8601,
                          msg: message,
                          callbackOption: 'NONE'
                      }
                  }.to_json,
                  headers: {
                      'Content-Type' => 'application/json',
                      'Authorization' => "Basic #{@auth}",
                      'Accept' => 'application/json'
                  }
    )
  end
end
