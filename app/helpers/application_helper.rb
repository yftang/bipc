module ApplicationHelper
  def page_title
    base = 'BIPC'
    @title_name ? "#{@title_name} - #{base}" : base
  end

  def role_tag(role, disabled='')
    role = role.to_s.camelize
    gliph_span = "<span class='glyphicon glyphicon-user'></span>" if \
        role.include?('Admin')
    btn_base = "<button type='button' class='btn btn-sm btn-primary' " + \
               "disabled='disabled'>#{gliph_span} %s</button>"
    btn_base = sanitize(btn_base,
                        :tags => ['button', 'span'],
                        :attributes => ['type', 'class', "#{disabled.to_s}"])

    if role.include?('Marketing')
      return btn_base % 'MKT'
    elsif role.include?('Salesman')
      return btn_base % 'SMN'
    elsif role.include?('Experimenter')
      return btn_base % 'EXP'
    elsif role.include?('Bioinformatician')
      return btn_base % 'BIN'
    elsif role.include?('Admin')
      return btn_base % 'ADM'
    else
      return
    end
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
