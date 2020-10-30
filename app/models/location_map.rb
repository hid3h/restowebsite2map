class LocationMap
  attr_accessor :title, :address, :latitude, :longitude

  def initialize(title)
  end

  class << self
    def fetch(url: url)
      # スクレイピングします
      Scraper.new(url: url)
    end
  end
end
