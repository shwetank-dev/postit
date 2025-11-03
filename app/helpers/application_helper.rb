module ApplicationHelper
  def fix_url(str)
    str.starts_with?('http//') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    # Convert dt to New York time and format
    dt.in_time_zone("America/New_York").strftime("%m/%d/%Y %l:%M%P %Z")
  end
end
