require "tinder"

class Campfire
  def initialize
    required_environment_variables %w(CAMPFIRE_SUBDOMAIN CAMPFIRE_OAUTH_TOKEN)

    @client ||= Tinder::Campfire.new(ENV["CAMPFIRE_SUBDOMAIN"], :token => ENV["CAMPFIRE_OAUTH_TOKEN"])
  end

  def ops
    @client.find_room_by_name("Ops")
  end

  private
  def required_environment_variables(array)
    array.each do |str|
      raise "Must set #{str}" unless ENV[str]
    end
  end
end
