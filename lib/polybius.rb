module Polybius
  SHA = `git rev-parse HEAD`.chomp.freeze

  def self.sha
    SHA
  end
end
