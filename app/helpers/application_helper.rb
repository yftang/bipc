module ApplicationHelper
  def page_title
    base = 'BIPC'
    @title_name ? "#{@title_name} - #{base}" : base
  end
end
