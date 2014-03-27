module ApplicationHelper

  def most_common_value(a)
    a.group_by do |e|
      e
    end.values.max_by(&:size).first   # TODO  see if .first(5) works
  end

  def format_date(time)
   time.strftime("%l %P %B %d, %Y")
  end

end
