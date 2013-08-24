require "campfire"

module Polybius
  SHA = `git rev-parse HEAD`.chomp.freeze

  def self.sha
    SHA
  end

  def self.notify_ops(hash)
    if hash[:user]
      campfire.ops.speak "Incident ##{hash[:number]} assigned to #{hash[:user]} is now #{hash[:status]} on #{hash[:svc]}"
    else
      campfire.ops.speak "Incident ##{hash[:number]} is now #{hash[:status]} on #{hash[:svc]}"
    end
  end

  def self.campfire
    @campfire ||= Campfire.new
  end
end
