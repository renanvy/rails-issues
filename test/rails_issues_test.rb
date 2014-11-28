require 'json'
require 'minitest/autorun'
require_relative '../lib/rails_issues'


describe RailsIssues do

  before do
    @subject = RailsIssues.new
    @issue = { "created_at" => "2014-11-28T13:49:51Z", "closed_at" => "2014-11-28T13:52:33Z" }
  end

  describe "#time_opened" do
    it "should return issue's time opened" do
      assert_equal(@subject.time_opened(@issue), "00:02:42")
    end
  end

  describe "#average_time_opened" do
    it "should return average time opened all issues" do
      assert_equal(@subject.average_time_opened, "02:54:36")
    end
  end
end