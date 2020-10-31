class LocationReplyer
  def initialize(line_event:)
    @line_event = line_event
  end

  def executable?
    !urls.empty?
  end

  def execute
    message_hash = {}
    urls.each do |url|
      location = Location.new(url: url)
      next unless location

      message_hash = {
        type:      'location',
        title:     location.title,
        address:   location.address,
        latitude:  location.latitude,
        longitude: location.longitude
      }

      # 今のとこひとつだけ返す
      break if message_hash.all?
    end

    line_bot_client.reply_message(
      reply_token: @line_event.reply_token,
      message: message_hash
    )
  end

  private

  def urls
    URI.extract(text)
  end

  def text
    @line_event.text
  end

  def line_bot_client
    @line_bot_client ||= LineBotClient.new
  end
end
