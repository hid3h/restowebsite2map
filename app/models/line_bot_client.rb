class LineBotClient
  def initialize
    @client = Line::Bot::Client.new { |config|
      config.channel_secret = channel_secret
      config.channel_token  = channel_token
    }
  end

  def channel_secret
    ENV["LINE_CHANNEL_SECRET"]
  end

  def channel_token
    ENV["LINE_CHANNEL_TOKEN"]
  end

  def get_profile(user_id)
    response = @client.get_profile(user_id)
    JSON.parse(response.body)
  end

  def reply_message(reply_token:, message:)
    @client.reply_message(reply_token, message)
  end
end
