require 'minitest/autorun'
require "json"
require "open-uri"
require_relative '../lib/rails_issues'

describe RailsIssues do

  before do
    @issues = JSON.load(open("https://api.github.com/repos/rails/rails/issues?state=closed"))
    puts @issues
  end

  describe "#issues" do
    it "should return one issue closed" do 
      assert_equal(@issues[0]["title"], "Update cookies.rb")
    end
  end

  describe "#time_opened" do
    it "should return time to finish issues" do
      created_at = Time.parse(@issue[0]['created_at'])
      closed_at  = Time.parse(@issue[0]['closed_at'])
      seconds    = closed_at - created_at
      assert_equal(time_opened(@issue[0]), Time.at(seconds).utc.strftime("%H:%M:%S"))
    end
  end

  describe "#convert_seconds_to_formatted_time" do
    it "should convert seconds" do
      created_at = Time.parse(@issue[0]['created_at'])
      closed_at  = Time.parse(@issue[0]['closed_at'])
      seconds    = closed_at - created_at
      assert_equal(convert_seconds_to_formatted_time(seconds), Time.at(seconds).utc.strftime("%H:%M:%S"))
    end
  end
end