require "campfire"
require "polybius/notification_formatter"

module Polybius
  class CampfireNotifier

    def initialize
      @campfire = Campfire.new
    end

    def notify!(payload)
      message = Polybius::NotificationFormatter.new(payload).message

      @campfire.speak "[PagerDuty] #{message}"
    end

  end
end
