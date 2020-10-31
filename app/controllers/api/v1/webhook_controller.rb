class Api::V1::WebhookController < ApplicationController
  # https://developers.line.biz/ja/reference/messaging-api/#webhooks
  def receive
    return unless validate_sinature
    line_event = LineEvent.new(events: params['events'])
    temp = Location.new(line_event: line_event)
    temp.execute if temp.executable?

    render :json => 'ok'
  end

  def test
    render :json => "test"
  end

  private

  # TODO
  def validate_sinature
    return true
    p "request", request.headers
    http_request_body = request.raw_post # Request body string
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, http_request_body)
    signature = Base64.strict_encode64(hash)
    # Compare X-Line-Signature request header string and the signature
    signature == request.headers['X-Line-Signature']
  end

  def channel_secret
    ENV["LINE_CHANNEL_SECRET"]
  end
end
