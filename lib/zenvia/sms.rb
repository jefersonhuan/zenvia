require 'httparty'
require 'json'
require 'timeout'

module Zenvia
  class SMS
    
    def self.lookup(id)
      begin
        res = self.get_status id
        JSON.parse res.body
      rescue => e
        puts "Error!\n#{e}"
      end
    end

    # function to send the message
    def self.send_message(number, message, options = {})
      begin
        @responses = []
        @from = options[:from].nil? ? Zenvia.config.from : options[:from]
        @message = message
        @options = options
        numbers = number.is_a?(Array) ? number : number.split

        numbers.each do |nb|
          @number = nb
          response = self.send_one_request
          @responses.push JSON.parse(response.body)
        end

        treat_response
      rescue => e
        puts "Error!\n#{e}"
      end
    end

    def self.send_multiple_messages(list = [], aggregate_id = nil)
      begin
        @list = list
        @aggregate_id = aggregate_id
        validate_list!

        if @errors[:errors].empty?
          response = self.send_multiple_requests
          JSON.parse response.body
        else
          @errors
        end
      rescue => e
        puts "Error!\n#{e}"
      end
    end

    private
      def self.send_one_request
        @number = treat_number @number
        endpoint = 'https://api-rest.zenvia360.com.br/services/send-sms'
        HTTParty.post(endpoint,
          body: {
              sendSmsRequest: {
                  from: @from,
                  to: @number,
                  msg: @message,
                  id: @options[:id],
                  schedule: @options[:schedule],
                  aggregateId: @options[:aggregate_id],
                  callbackOption: 'NONE'
              }
          }.to_json,
          headers: self.headers
        )
      end

      def self.send_multiple_requests
        endpoint = 'https://api-rest.zenvia360.com.br/services/send-sms-multiple'
        HTTParty.post(endpoint,
          body: {
              sendSmsMultiRequest: {
                aggregateId: @aggregate_id,
                sendSmsRequestList: @list
            }
          }.to_json,
          headers: self.headers
        )
      end

      def self.get_status(id)
        endpoint = "https://api-rest.zenvia360.com.br/services/get-sms-status/#{id}"
        HTTParty.get(endpoint, headers: {
            'Authorization' => "Basic #{Zenvia.config.auth}"
          }
        )
      end

      def self.treat_number(number)
        number = number.to_s unless number.is_a? String
        patterns = ['(', ')', ' ', '-']
        patterns.each {|p| number = number.gsub(p, '')}
        number.insert(0, '55') unless /^55/.match(number)
        number
      end

      def self.validate_list!
        @errors = {errors: []}

        @list.each do |data|
          @list[@list.index(data)][:to] = treat_number data[:to]

          @errors[:errors].push to: 'required' unless data.include?(:to)
          @errors[:errors].push msg: 'required' unless data.include?(:msg)

          break if @errors[:errors].any?
        end
      end

      def self.treat_response
        @responses.count == 1 ? @responses.first : @responses
      end

      def self.headers
        {
            'Content-Type' => 'application/json',
            'Authorization' => "Basic #{Zenvia.config.auth}",
            'Accept' => 'application/json'
        }
      end
  end
end