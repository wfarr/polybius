require "json"
require "polybius"
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

    messages.each { |message| Polybius::CampfireNotifier.new.notify! message }

    [200, "OK"]
  end
end
