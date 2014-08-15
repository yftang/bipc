module ApplicationHelper
  def page_title
    base = 'BIPC'
    @title_name ? "#{@title_name} - #{base}" : base
  end

  def has_error?(object, field)
    "has-error" if object.errors.try(:messages).has_key?(field)
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
