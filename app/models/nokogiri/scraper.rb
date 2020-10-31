require 'open-uri'

class Nokogiri::Scraper
  def initialize(url:)
    @url = url
  end

  def doc
    @doc ||= Nokogiri::HTML(URI.open(url))
  end

  def url
    @url
  end
end
