class Scraper

  SCRAPERS = [
    Nokogiri::Tabelog
  ]

  def initialize(url:)
    @url = url
    set_scraper_type
  end

  def fetch_location
    raise if @scraper.nil?
    @doc = Nokogiri::HTML(URI.open(url))
    @scraper.extract_location(@doc)
    # {
    #   title: @scraper.title,
    #   address: @scraper.address,
    #   latitude: @scraper.latitude,
    #   longitude: @scraper.longitude
    # }
  end

  private
  
  def set_scraper_type
    SCRAPERS.each do |scraper|
      obj = scraper.new(url: @url)
      next unless obj.scrapable?
      @scraper = obj
      return
    end
  end
end
