class Api::V1::WebhookController < ApplicationController
  # https://developers.line.biz/ja/reference/messaging-api/#webhooks
  def receive
    unless validate_sinature
      return render status: 401, json: { status: 401, message: 'Unauthorized' }
    end

    line_event = LineEvent.new(events: params['events'])
    temp = Location.new(line_event: line_event)
    temp.execute if temp.executable?

    render :json => 'ok'
  end

  def test
    render :json => "test"
  end

  private

  def validate_sinature
    http_request_body = request.body.read # Request body string
    hash = OpenSSL::HMAC::digest(OpenSSL::Digest::SHA256.new, channel_secret, http_request_body)
    signature = Base64.strict_encode64(hash)
    # Compare X-Line-Signature request header string and the signature
    signature == request.headers['x-line-signature']
  end

  def channel_secret
    ENV["LINE_CHANNEL_SECRET"]
  end
end
