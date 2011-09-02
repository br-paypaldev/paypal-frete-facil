# encoding: UTF-8
require 'net/https'
require 'uri'

module PayPal
  module FreteFacil
    class WebService
      URL = "https://ff.paypal-brasil.com.br/FretesPayPalWS/WSFretesPayPal"

      def initialize
        @uri = URI.parse(URL)
      end

      def request(frete)
        http = Net::HTTP.new(@uri.host, @uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Post.new(@uri.path)
        request["Content-Type"] = "text/xml; charset=utf-8"
        request["SoapAction"] = "#{URL}/getPreco"
        request.body = request_body_for(frete)

        with_log(request) { http.request(request) }
      end

      private

      def request_body_for(frete)
        "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:frete=\"https://ff.paypal-brasil.com.br/FretesPayPalWS\">" +
          "<soapenv:Header />" +
          "<soapenv:Body>" +
            "<frete:getPreco>" +
              "<cepOrigem>#{frete.cep_origem}</cepOrigem>" +
              "<cepDestino>#{frete.cep_destino}</cepDestino>" +
              "<largura>#{frete.largura}</largura>" +
              "<altura>#{frete.altura}</altura>" +
              "<profundidade>#{frete.profundidade}</profundidade>" +
              "<peso>#{frete.peso}</peso>" +
            "</frete:getPreco>" +
          "</soapenv:Body>" +
        "</soapenv:Envelope>"
      end

      def with_log(request)
        PayPal::FreteFacil.log format_request_message(request)
        response = yield
        PayPal::FreteFacil.log format_response_message(response)
        response.body
      end

      def format_request_message(request)
        format_message(request) do |message|
          message =  with_line_break { "PayPal-Frete-Facil Request:" }
          message << with_line_break { URL }
        end
      end

      def format_response_message(response)
        format_message(response) do |message|
          message =  with_line_break { "PayPal-Frete-Facil Response:" }
          message << with_line_break { "HTTP/#{response.http_version} #{response.code} #{response.message}" }
        end
      end

      def format_message(http)
        message = yield
        message << with_line_break { format_headers_for(http) } if PayPal::FreteFacil.log_level == :debug
        message << with_line_break { http.body }
      end

      def format_headers_for(http)
        # I'm using an empty block in each_header method for Ruby 1.8.7 compatibility.
        http.each_header{}.map { |name, values| "#{name}: #{values.first}" }.join("\n")
      end

      def with_line_break
        "#{yield}\n"
      end
    end
  end
end
