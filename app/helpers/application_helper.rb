module ApplicationHelper
  def date object
    object.strftime '%Y年%m月%d号'
  end

  def date_and_time object
    object.strftime '%Y年%m月%d号 %H:%M:%S'
  end
end
