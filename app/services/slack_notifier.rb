require 'net/http'
require 'uri'
require 'json'

class SlackNotifier
  def self.send_message(message)
    webhook_url = Rails.application.credentials.dig(:slack, :webhook_url)
    return unless webhook_url

    uri = URI(webhook_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json' })
    request.body = { text: message }.to_json

    response = http.request(request)
    Rails.logger.info "Slack Response: #{response.body}"
  end
end
