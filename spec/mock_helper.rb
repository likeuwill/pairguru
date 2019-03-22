module MockHelper
  ENDPOINT = /pairguru-api.herokuapp.com/

  def valid_response
    stubbed_response = JSON.parse(file_fixture("movie_response.json").read)

    stub_request(:get, ENDPOINT)
      .with(headers)
      .to_return(
        status: 200,
        body: stubbed_response.to_json,
        headers: json_headers
      )
  end

  def invalid_response
    stub_request(:get, ENDPOINT)
      .with(headers)
      .to_return(
        status: 400,
        body: { "errors": "" }.to_json,
        headers: json_headers
      )
  end

  def headers
    { headers: { "Accept": "*/*", "User-Agent": "Ruby" } }
  end

  def json_headers
    { "Content-Type": "application/json" }
  end
end



