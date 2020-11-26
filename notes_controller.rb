require "httparty"
require "json"

class NotesController
  include HTTParty
  base_uri "https://keepable-api.herokuapp.com"

  def self.index(token)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
    }

    response = get("/notes", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create(note_data, token)
    options = {
      headers: { "Authorization" => "Token token=#{token}", "Content-Type" => "application/json" },
      body: note_data.to_json
    }

    response = post("/notes", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.update(id, note_data, token)
    options = {
      headers: { "Content-Type" => "application/json", "Authorization" => "Token token=#{token}" },
      body: note_data.to_json
    }

    response = patch("/notes/#{id}", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destroy(id, token)
    options = {
      headers: { "Content-Type" => "application/json", "Authorization" => "Token token=#{token}" },
    }

    response = delete("/notes/#{id}", options)
    raise Net::HTTPError.new(response.parsed_response, response) unless response.success?
    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end