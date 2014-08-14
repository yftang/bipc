module ApplicationHelper
  def page_title
    base = 'BIPC'
    @title_name ? "#{@title_name} - #{base}" : base
  end

  def has_error?(object, field)
    "has-error" if object.errors.try(:messages).has_key?(field)
  end
end
