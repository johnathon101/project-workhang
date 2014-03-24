module ApplicationHelper
  def full_name(fname, lname)
    @full_name = "#{fname.titleize} #{lname.titleize}"
  end
end
