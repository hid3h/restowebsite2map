class LineEvent
  attr_reader :text

  def initialize(events:)
    event = events[0]
    @text = evemt['text']
  end

  def has_url?
    urls.present?
  end

  def urls
    URI.extract(text)
  end
end
