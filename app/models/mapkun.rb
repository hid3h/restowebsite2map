class Mapkun
  attr_reader :line_event

  def initialzie(line_event:)
    @line_event = line_event
  end

  def excute
    # textにurlが含まれていたら、スクレイピングする
    if line_event.has_url?
      # 地図を返信してください
      locations = Location.fetch(urls: line_event.urls)
    end
  end
end
