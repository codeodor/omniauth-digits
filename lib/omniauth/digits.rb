require "omniauth/strategies/digits/version"

module Omniauth
  module Strategies
    class Digits < OmniAuth::Strategies::OAuth
      include OmniAuth::Strategy

      option :name, 'digits'
      option :host, 'http://localhost:3000'
      option :client_options, {
        site: 'https://api.digits.com/1.1/sdk/account.json',
        authorize_url: "https://www.digits.com/login"
      }

      def request_phase
        # session["oauth"] ||= {}
#         session["oauth"][name.to_s] = {"callback_confirmed" => true, "request_token" => request_token.token, "request_secret" => request_token.secret}
#
#                 if request_token.callback_confirmed?
#                   redirect request_token.authorize_url(options[:authorize_params])
#                 else
#                   redirect request_token.authorize_url(options[:authorize_params].merge(:oauth_callback => callback_url))
#                 end
#
#               rescue ::Timeout::Error => e
#                 fail!(:timeout, e)
#               rescue ::Net::HTTPFatalError, ::OpenSSL::SSL::SSLError => e
#                 fail!(:service_unavailable, e)
#               end

        redirect "https://www.digits.com/login?consumer_key=#{options.consumer_key}&host=#{full_host}&callback_url=#{callback_url}"
      end

      def callback_phase
        uri = URI(options.client_options.site)
        req = Net::HTTP::Post.new(uri)

        extract_header_from_request_query_string.each do |header, value|
          req[header] = value
        end

        http = Net::HTTP.new(uri.hostname, uri.port)
        http.use_ssl = true
        res = http.request(req)

        raise res.body
      end

      private
      def extract_header_from_request_query_string
        q = URI.unescape(request.query_string)
        headers = []
        q.split("&").select{|v| v[0..1] == "X-"}.each do |header_string|
          header_name = header_string.split("=").first
          header_value = header_string.split("=")[1..-1].join("=")
          headers << [header_name, header_value]
        end

        headers
      end
    end
  end
end
