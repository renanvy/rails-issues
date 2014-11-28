require "json"
require "open-uri"

class RailsIssues

  def report
    issues.each do |issue|
      puts "Issue: #{issue['title']}: demorou #{time_opened(issue)} para encerrar"
    end

    puts ""

    puts "Media do tempo que levou para todas issues serem finalizadas: #{average_time_opened}"
  end

  private

  def issues
    JSON.load(open("https://api.github.com/repos/rails/rails/issues?state=closed"))
  end

  def time_opened(issue)
    created_at = Time.parse(issue['created_at'])
    closed_at  = Time.parse(issue['closed_at'])
    seconds    = closed_at - created_at
    convert_seconds_to_formatted_time(seconds)
  end

  def average_time_opened
    total_seconds = 0

    issues.each do |issue| 
      total_seconds += Time.parse(issue['closed_at']) - Time.parse(issue['created_at'])
    end

    average = total_seconds / issues.length
    convert_seconds_to_formatted_time(average)
  end

  def convert_seconds_to_formatted_time(seconds)
    Time.at(seconds).utc.strftime("%H:%M:%S")
  end
end

rails_issues = RailsIssues.new
rails_issues.report