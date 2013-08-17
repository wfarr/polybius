require "test_helper"

require "polybius/app"

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Polybius::App
  end

  def test_get_sha
    Polybius.stub :sha, "87dbaf3" do
      get "/sha"

      assert last_response.ok?
      assert_equal "87dbaf3", last_response.body
    end
  end

  def test_post_receive
    post "/receive", messages.to_s, "CONTENT_TYPE" => "application/json"

    assert last_response.ok?
  end


  private
  def messages
    <<-EOS
{
  "messages": [
    {
      "id": "bb8b8fe0-e8d5-11e2-9c1e-22000afd16cf",
      "created_on": "2013-07-09T20:25:44Z",
      "type": "incident.trigger",
      "data": {
        "incident": {
          "id": "PIJ90N7",
          "incident_number": 1,
          "created_on": "2013-07-09T20:25:44Z",
          "status": "triggered",
          "html_url": "http://acme.pagerduty.com/incidents/PIJ90N7",
          "incident_key": "null",
          "service": {
            "id": "PBAZLIU",
            "name": "service",
            "html_url": "http://acme.pagerduty.com/services/PBAZLIU"
          },
          "assigned_to_user": {
            "id": "PPI9KUT",
            "name": "Alan Kay",
            "email": "alan@pagerduty.com",
            "html_url": "http://acme.pagerduty.com/users/PPI9KUT"
          },
          "trigger_summary_data": {
            "subject": "45645"
          },
          "trigger_details_html_url": "http://acme.pagerduty.com/incidents/PIJ90N7/log_entries/PIJ90N7",
          "last_status_change_on": "2013-07-09T20:25:44Z",
          "last_status_change_by": "null",
          "number_of_escalations": 0
        }
      }
    },
    {
      "id": "8a1d6420-e9c4-11e2-b33e-f23c91699516",
      "created_on": "2013-07-09T20:25:45Z",
      "type": "incident.resolve",
      "data": {
        "incident": {
          "id": "PIJ90N7",
          "incident_number": 1,
          "created_on": "2013-07-09T20:25:44Z",
          "status": "resolved",
          "html_url": "http://acme.pagerduty.com/incidents/PIJ90N7",
          "incident_key": "null",
          "service": {
            "id": "PBAZLIU",
            "name": "service",
            "html_url": "http://acme.pagerduty.com/services/PBAZLIU"
          },
          "assigned_to_user": "null",
          "resolved_by_user": {
            "id": "PPI9KUT",
            "name": "Alan Kay",
            "email": "alan@pagerduty.com",
            "html_url": "http://acme.pagerduty.com/users/PPI9KUT"
          },
          "trigger_summary_data": {
            "subject": "45645"
          },
          "trigger_details_html_url": "http://acme.pagerduty.com/incidents/PIJ90N7/log_entries/PIJ90N7",
          "last_status_change_on": "2013-07-09T20:25:45Z",
          "last_status_change_by": {
            "id": "PPI9KUT",
            "name": "Alan Kay",
            "email": "alan@pagerduty.com",
            "html_url": "http://acme.pagerduty.com/users/PPI9KUT"
          },
          "number_of_escalations": 0
        }
      }
    }
  ]
}
EOS
  end
end
