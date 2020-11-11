class Client::Gurunavi
  ENDPOINT = "https://api.gnavi.co.jp/RestSearchAPI/v3/"
  
  def self.requestable?(url)
    url.include?("gnavi")
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
      keyid: api_key,
      id:    id
    }.to_param
    
    uri.to_s
  end

  def title
    item['name']
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

  def item
    p "response['results']", response["error"][0]['message']
    @shop ||= response['rest'][0]
  end

  def id
    # url, "https://r.gnavi.co.jp/af7rvm2p0000/"
    @url.split('gnavi.co.jp/')[1].split('/')[0]
  end

  def api_key
    "74c78c88aa5abebd59fc0b65e4ae2f1b"
  end
end
