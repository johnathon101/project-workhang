module ApplicationHelper

  def format_date(time)
   time.strftime("%l %P %B %d, %Y")
  end

end
