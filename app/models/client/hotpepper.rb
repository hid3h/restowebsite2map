class Client::Hotpepper
  ENDPOINT = "https://webservice.recruit.co.jp/hotpepper/gourmet/v1/"
  
  def self.requestable?(url)
    url.include?("hotpepper.jp")
  end

  def initialize(url:)
    @url = url
  end

  def response
    uri = URI.parse(endpoint)
    res = Net::HTTP.get_response(uri)
    @response ||= JSON.parse(res.body)
  end

  def endpoint
    uri = URI(ENDPOINT)
    uri.query = {
      key:    api_key,
      id:     id,
      format: 'json'
    }.to_param
    
    uri.to_s
  end

  def title
    shop['name']
  end

  def address
    doc.css('.rstinfo-table__address')[0].text
  end

  def latitude
    query_hash['lat']
  end

  def longitude
    query_hash['lng']
  end

  private

  def shop
    p "response['results']", response
    @shop ||= response['results']['shop'][0]
  end

  def id
    # url, https://www.hotpepper.jp/strJ001238869/
    @url.split('str')[1].split('/')[0]
  end

  def api_key
    ENV["HOTPEPPER_API_KEY"]
  end
end
