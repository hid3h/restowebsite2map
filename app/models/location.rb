class Location
  def initialize(line_event:)
    @line_event = line_event
  end

  def executable?
    true
  end

  def excute
    # mapを取得して
    location_map = Scraper.new(url: url).scrape
    # replyする
    message_hash = {
      type:      'location',
      title:     location_map.title,
      address:   location_map.address,
      latitude:  location_map.latitude,
      longitude: location_map.longitude
    }
    reply_message(
      reply_token: @line_event.reply_token,
      message: message_hash
    )
  end
end
