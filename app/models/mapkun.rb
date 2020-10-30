# どういう時にどんな処理を行うか知っている
class Mapkun
  attr_reader :line_event

  def initialzie(line_event:)
    @line_event = line_event
  end

  def excute
    if line_event.has_url?
      # 地図を返信してください
      Location.new(line_event: line_event).excute
    end
  end
end
