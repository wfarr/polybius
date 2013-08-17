require "polybius"


require "sinatra/base"


class Polybius::App < Sinatra::Base

  get "/" do
    ":poop:"
  end

  get "/sha" do
    Polybius.sha
  end

end
