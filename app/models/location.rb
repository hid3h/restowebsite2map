class Location

  CLIENT_CANDIDATES = [
    # Client::Hotpepper,
    Client::Gurunavi,
    Nokogiri::Tabelog
  ]

  def initialize(url:)
    @url = url
    set_client
  end

  def title
    client.title
  end

  def address
    client.address
  end

  def latitude
    client.latitude
  end

  def longitude
    client.longitude
  end

  private

  def client
    @client
  end
  
  def set_client
    CLIENT_CANDIDATES.each do |candidate|
      next unless candidate.requestable?(@url)

      @client = candidate.new(url: @url)
      return
    end
  end
end
