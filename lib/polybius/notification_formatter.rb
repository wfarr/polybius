module Polybius
  class NotificationFormatter

    def initialize(payload)
      @payload = payload
    end

    def message
      case type
      when :trigger
        "Incident #{incident_number} triggered and assigned to #{assigned_to_user}: #{summary} (#{url})"
      when :acknowledge
        "Incident #{incident_number} acknowledged by #{last_change_user}, assigned to #{assigned_to_user}: #{summary} (#{url})"
      when :unacknowledge
        "Incident #{incident_number} acknowledgement timed out, triggered and assigned to #{assigned_to_user}: #{summary} (#{url})"
      when :resolve
        "Incident #{incident_number} was resolved by #{resolved_by_user}: #{summary} (#{url})"
      when :assign
        "Incident #{incident_number} manually re-assigned to #{assigned_to_user}: #{summary} (#{url})"
      when :escalate
        "Incident #{incident_number} escalated to #{escalated_to_user} by #{last_change_user}: #{summary} (#{url})"
      when :delegate
        "Incident #{incident_number} manually re-assigned to #{assigned_to_user} by #{last_change_user}: #{summary} (#{url})"
      else
        raise "wat"
      end
    end


    private

    def type
      @payload["type"].split(".").last.to_sym
    end

    def summary
      incident["trigger_summary_data"]["subject"]
    end

    def incident_number
      incident["incident_number"]
    end

    def url
      incident["html_url"]
    end

    def assigned_to_user
      if incident.has_key? "assigned_to_user"
        if incident["assigned_to_user"]
          incident["assigned_to_user"]["name"]
        else
          "lol who the fuck knows"
        end
      else
        "lol who the fuck knows"
      end
    end

    def last_change_user
      if incident.has_key? "last_status_change_by"
        if incident["last_status_change_by"]
          incident["last_status_change_by"]["name"]
        else
          "lol who the fuck knows"
        end
      else
        "lol who the fuck knows"
      end
    end

    def resolved_by_user
      incident["resolved_by_user"]["name"]
    end

    def incident
      @incident ||= data["incident"]
    end

    def data
      @data ||= @payload["data"]
    end

  end
end
