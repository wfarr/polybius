require "polybius"

require "campfire"
require "json"

require "sinatra/base"


class Polybius::App < Sinatra::Base

  get "/" do
    ":poop:"
  end

  get "/sha" do
    Polybius.sha
  end

  post "/receive" do
    messages = JSON.parse(request.body.read)["messages"]

    messages.each do |message|
      Polybius.notify_ops \
        type:   message["type"],
        number: message["data"]["incident"]["incident_number"],
        status: message["data"]["incident"]["status"],
        svc:    message["data"]["incident"]["service"]["name"],
        user:   message["data"]["incident"]["assigned_to_user"]["name"]
    end

    [200, "OK"]
  end
end
