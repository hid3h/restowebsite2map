class Location
  def initialize(line_event:)
    @line_event = line_event
  end

  def executable?
    return false if URI.extract(text).empty?
    true
  end

  def execute
    urls = URI.extract(text)

    message_hash = {}
    urls.each do |url|
      scraper = Scraper.new(url: url)
      message_hash = {
        type:      'location',
        title:     scraper.title,
        address:   scraper.address,
        latitude:  scraper.latitude,
        longitude: scraper.longitude
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

  def text
    @line_event.text
  end

  def line_bot_client
    @line_bot_client ||= LineBotClient.new
  end
end
