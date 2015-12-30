require 'httparty'
require 'json'

class Zenvia::SMS
  attr_writer :from, :number, :message

  # initiate SMS object with
  # from: user or enterprise name, number: receiver number, message: text
  def initialize(from = nil, number, message)
    @from = from.nil? ? Zenvia.config.name : from
    @number = number
    exit puts 'letters and other special chars are not accepted in number parameter' unless /^\d*$/.match(@number)
    @message = message
  end

  def send_message
    response = send_sms
    response = JSON.parse(response.body)
    puts response['sendSmsResponse']['detailDescription']
  end

  private
  def send_sms
    # convert number to string (if isn't yet) and insert the country code (standard: BR, 55)
    # if not found
    @number = @number.to_s unless @number.class.eql? String
    @number.insert(0, '55') unless /^55/.match(@number)
    # retrieve auth value set in Config class
    @auth = Zenvia.config.auth
    # Zenvia api's endpoint to send sms
    endpoint = 'https://api-rest.zenvia360.com.br/services/send-sms'
    HTTParty.post(endpoint,
                  body: {
                      sendSmsRequest: {
                          from: @from,
                          to: @number,
                          msg: @message,
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