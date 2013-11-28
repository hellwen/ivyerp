module BootstrapHelper                                                     
  def boot_page_title(action_or_title = nil, model = nil)
    if action_or_title.is_a? String
      title = action_or_title
    else
      action = action_or_title || action_name
      if action.to_s == 'show' && defined?(resource) && resource.present?
        title = resource.to_s
      else
        title = t_title(action, model)
      end
    end

    content_for :page_title, title
    content_tag(:div, :class => 'page-header') do
      content_tag(:h1, title)
    end
  end

  # Icons
  def boot_icon(type)
    content_tag(:i, '', :class => "icon-#{type}")
  end

  # Messages
  # ======
  def boot_alert(*args, &block)
    if block_given?
      type = args[0]
      content = capture(&block)
    else
      content = args[0]
      type    = args[1]
    end

    type ||= 'info'
    content_tag(:div, :class => "alert alert-block alert-#{type} fade in") do
      link_to('&times;'.html_safe, '#', :class => 'close', 'data-dismiss' => 'alert') + content
    end
  end

  def boot_no_entry_alert
    boot_alert t('alerts.empty')
  end
end
