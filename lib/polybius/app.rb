require "json"
require "polybius"
require "sinatra/base"

class Polybius::App < Sinatra::Base

  set :logging, true

  get "/" do
    ":poop:"
  end

  get "/sha" do
    Polybius.sha
  end

  post "/receive" do
    messages = JSON.parse(request.body.read)["messages"]

    messages.each do |message|
      puts message.inspect

      Polybius::CampfireNotifier.new.notify! message
    end

    [200, "OK"]
  end
end
