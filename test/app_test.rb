require "test_helper"

require "polybius/app"

class AppTest < MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Polybius::App
  end

  def test_get_root
    get "/"

    assert last_response.ok?
    assert_equal ":poop:", last_response.body
  end

  def test_get_sha
    Polybius.stub :sha, "87dbag3" do
      get "/sha"

      assert last_response.ok?
      assert_equal "87dbag3", last_response.body
    end
  end
end
