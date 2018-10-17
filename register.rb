require 'faraday'
require 'json'

HOST = 'http://10.12.217.122:9090'

conn = Faraday.new(url: HOST) do |faraday|
  faraday.adapter Faraday.default_adapter
  faraday.headers['Content-Type'] = 'application/json'
end

payload = {
  "host" => "10.12.217.183",
  "port" => 8090,
  "team" => {
    "name" => "The Rubots",
    "lang" => "Ruby",
    "members" => [
      {
        "name" => "Kuba Suder",
        "github" => "https://github.com/mackuba"
      },
      {
        "name" => "Karol Gil",
        "github" => "https://github.com/karolgil"
      },
      {
        "name" => "Michal Bugno",
        "github" => "https://github.com/michalbugno"
      }
    ]
  }
}

resp = conn.post do |req|
  req.url '/v1/register'
  req.body = JSON.dump(payload)
end
p resp
