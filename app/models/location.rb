class Location
  class << self
    def fetch(urls:)
      locations = []
      urls.each do |url|
        location_hash = Scraper.new(url: url).fetch_location
        # 取れたら
      end
     locations
    end
  end
end
