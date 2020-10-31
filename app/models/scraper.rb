class Scraper

  SCRAPER_CANDIDATES = [
    Nokogiri::Tabelog
  ]

  def initialize(url:)
    @url = url
    set_scraper
  end

  def title
    @scraper.title
  end

  def address
    @scraper.address
  end

  def latitude
    @scraper.latitude
  end

  def longitude
    @scraper.longitude
  end

  private
  
  def set_scraper
    SCRAPER_CANDIDATES.each do |candidate|
      next unless candidate.scrapable?(@url)

      @scraper = candidate.new(doc: Nokogiri::HTML(URI.open(@url)))
      return
    end
  end
end
