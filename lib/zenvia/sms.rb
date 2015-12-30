require 'httparty'
require 'json'

module Zenvia
  class SMS
    attr_writer :from, :number, :message

    # function to send the message
    # from: user or enterprise name, number: receiver number, message: text
    def self.send_message(from = nil, number, message)
      begin
        @from = from.nil? ? Zenvia.config.from : from
        @number = number
        @message = message
        response = self.send_sms
        # todo improve returning message with auth error
        response = JSON.parse(response.body)
        puts response['sendSmsResponse']['detailDescription']
      rescue => e
        puts 'Error!'
        raise e
      end
    end

    private
    def self.send_sms
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
end