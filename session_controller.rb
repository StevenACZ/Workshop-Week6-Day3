require "httparty"
require "json"

class SessionController
  include HTTParty
  base_uri "https://keepable-api.herokuapp.com"

  def self.login(login_data)
    options = {
      headers: { "Content-Type" => "application/json" },
      body: login_data.to_json
    }

    response = post("/login", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end
end