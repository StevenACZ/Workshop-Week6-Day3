require "httparty"
require "json"

class UserController
  include HTTParty
  base_uri "https://keepable-api.herokuapp.com"

  def self.create(user_data)
    options = {
      headers: { "Content-Type" => "application/json" },
      body: user_data.to_json
    }

    response = post("/signup", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end
end