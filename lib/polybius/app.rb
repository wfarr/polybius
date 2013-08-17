require "polybius"

require "json"
require "scrolls"
require "sinatra/base"


class Polybius::App < Sinatra::Base

  Scrolls.global_context app: "polybius", deploy: Polybius.sha[0..7]

  get "/sha" do
    Polybius.sha
  end

  post "/receive" do
    Scrolls.log action: "POST", route: "/receive" do
      messages = JSON.parse(request.body.read.to_s)["messages"]

      messages.each do |message|
        metadata = {
          incident_number: message["data"]["incident"]["number"],
          status:          message["data"]["incident"]["status"],
          type:            message["type"],

        }

        Scrolls.log metadata
      end
    end
  end
end
