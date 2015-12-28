require "zenvia/version"
require 'httparty'
require 'base64'
require 'json'

class Zenvia
  # initialize Zenvia class with user and code, both given from Zenvia (the corp)
  def initialize(user, code)
    return puts 'User and code must no be nil' if user.nil? or code.nil?
    # such as done in shell (echo -n user:code | base64), the strip method removes '\n' from the generated code
    @auth = Base64.encode64("#{user}:#{code}").strip
  end

  attr_writer :auth

  # send the message itself, from: user or enterprise name, number: receiver number, message: text
  # delay: given in seconds to determinate
  def send_message(from, number, message, delay = 0)
    return puts 'The receiver must not be nil' if number.nil?
    return puts 'The sender cannot be nil' if from.nil?
    number = number.to_s unless number.class.eql? String
    return puts 'The number must have just numbers!' unless /\d*/.match(number)
    response = send_sms(from, number, message, delay)
    response = JSON.parse(response.body)
    puts 'Response: ' + response['sendSmsResponse']['statusDescription']
  end

  private
  # todo add multiple sms
  def send_sms(from, number, message, delay)
    # due to timezone, I decided to use strftime in order to send the message instantly
    schedule = (Time.now + delay).strftime("%Y-%m-%dT%H:%M:%S")
    number.insert(0, '55') unless /^55/.match(number)
    endpoint = 'https://api-rest.zenvia360.com.br/services/send-sms'
    HTTParty.post(endpoint,
                  body: {
                      sendSmsRequest: {
                          from: from,
                          to: number,
                          schedule: schedule,
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
