# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  # Sidebar Filters
  def define_filter(name, &block)
    @filters ||= {}
    # Do nothing if filter is already registered
    return if @filters[name]

    @filters[name] = true
    content_for :sidebar do
      yield
    end
  end

  include ActionView::Helpers::NumberHelper
  def currency_fmt(value)
    # We often do get -0.0 but don't like it
    value = 0.0 if value.to_s.match %r{^-[0.]*$}

    number = number_with_precision(value, :precision => 2, :separator => '.', :delimiter => "'")
  end

  # CRUD helpers
  def icon_edit_link_to(path)
    link_to t('ivyerp.edit'), path, :method => :get, :class => 'icon-pencil', :title => t('ivyerp.edit')
  end

  def icon_delete_link_to(model, path)
    link_to t('ivyerp.destroy'), path, :remote => true, :method => :delete, :confirm => t_confirm_delete(model), :class => 'icon-delete', :title => t('ivyerp.destroy')
  end

  def list_item_actions_for(resource)
    model_name = resource.class.to_s.underscore

    render 'layouts/list_item_actions_for', :model_name => model_name, :resource => resource
  end

  # Nested form helpers
  def show_new_form(model)
    model_name = model.to_s.underscore

    output = <<EOF
$('##{model_name}_list').replaceWith('#{escape_javascript(render('form'))}');
addAutofocusBehaviour();
addAutocompleteBehaviour();
addDatePickerBehaviour();
addAutogrowBehaviour();
EOF

    return output.html_safe
  end

  # List link helpers
  def list_link_to(action, url, options = {})
    options.merge!(:class => "icon-#{action}-text", :title => t_action(action))
    
    link_to(t_action(action), url, options)
  end
  
  def list_link_icon_for(action, resource_or_model = nil, options = {})
    action = action.to_s

    if resource_or_model.is_a? Array
      main_resource_or_model = resource_or_model.last
    else
      main_resource_or_model = resource_or_model
    end

    icon_tag = boot_icon(action)
    resource = main_resource_or_model || instance_variable_get("@#{controller_name.singularize}")
    model = resource.class

    return if respond_to?(:can?) and cannot?(action.to_sym, model)

    # Link generation
    case action
    when 'index', 'show'
      path = polymorphic_path(resource_or_model)
    when 'delete'
      path = polymorphic_path(resource_or_model)
      options.merge!(:confirm => t_confirm_delete(main_resource_or_model), :method => :delete)
    else
      path = polymorphic_path(resource_or_model, :action => action)
    end
     
    return link_to(icon_tag, path, options)
  end

  def list_link_for(action, resource_or_model = nil, options = {})
    # Handle both symbols and strings
    action = action.to_s
    
    # Resource and Model setup
    # Support nested resources
    if resource_or_model.is_a? Array
      main_resource_or_model = resource_or_model.last
    else
      main_resource_or_model = resource_or_model
    end
    
    # Use controller name to guess resource or model if not specified
    case action
    when 'new', 'index'
      model = main_resource_or_model || controller_name.singularize.camelize.constantize
    when 'show', 'edit', 'delete'
      resource = main_resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore
    
    # No link if CanCan is used and current user isn't authorized to call this action
    return if respond_to?(:can?) and cannot?(action.to_sym, model)
    
    # Link generation
    case action
    when 'index', 'show'
      path = polymorphic_path(resource_or_model)
    when 'delete'
      path = polymorphic_path(resource_or_model)
      options.merge!(:confirm => t_confirm_delete(main_resource_or_model), :method => :delete)
    else
      path = polymorphic_path(resource_or_model, :action => action)
    end
     
    return list_link_to(action, path, options)
  end
  
  def list_links_for(action = nil, resource_or_model = nil)
    # Use current action if not specified
    action ||= action_name
    
    # Handle both symbols and strings
    action = action.to_s
    
    actions = []
    case action
    when 'new', 'create'
      actions << 'index'
    when 'show'
      actions += ['edit', 'delete', 'index']
    when 'edit', 'update'
      actions += ['show', 'delete', 'index']
    when 'index'
      actions << 'new'
    end
    
    links = actions.map{|link_for| contextual_link_to(link_for, resource_or_model)}
    
    return links.join("\n").html_safe
  end

  def t_aasm(attribute)
    I18n::translate("aasm.#{attribute}")
  end

  def t_attr(attribute, model = nil)
    if model.is_a? Class
      #model_class = model
      context = model.name.underscore
    elsif model.nil?
      context = controller_name.singularize.underscore
    end

    begin
      I18n::translate("activerecord.attributes.#{context}.#{attribute}", :raise => true)
    rescue I18n::MissingTranslationData
      I18n::translate("attributes.#{attribute}")
    end
  end

  def t_model(model = nil)
    if model.is_a? Class
      model_name = model.name.underscore
    elsif model.nil?
      model_name = controller_name.singularize.underscore
    else
      model_name = model.class.name.underscore
    end
    I18n::translate(model_name, :scope => [:activerecord, :models])
  end

  def t_title(action = nil, model = nil)
    action ||= action_name
    #if model
    #  context = model.name.underscore
    #else
    #  context = controller_name.singularize.underscore
    #end

    I18n::translate("crud.title.#{action}", :model => t_model(model))
  end
  alias :t_crud :t_title
  
  def t_action(action = nil, model = nil)
    action ||= action_name
    I18n::translate(action, :scope => 'crud.action', :model => t_model(model))
  end
  
  def t_confirm_delete(record)
    I18n::translate('messages.confirm_delete', :model => t_model(record), :record => record.to_s)
  end

  def t_select_prompt(model = nil)
    I18n::translate('messages.select_prompt', :model => t_model(model))
  end

  # CRUD helpers
  def action_to_icon(action)
    case action.to_s
    when 'new'
      "plus"
    when 'show'
      "eye-open"
    when 'edit'
      "edit"
    when 'delete'
      "trash"
    when "index", "list"
      "list-alt"
    when "update"
      "refresh"
    when "copy"
      "repeat"
    else
      action
    end
  end

  def icon_link_to(action, url = nil, options = {})
    classes = []
    if class_options = options.delete(:class)
      classes << class_options.split(' ')
    end

    classes << "btn"

    if action.is_a? Symbol
      url ||= {:action => action}
      title = t_action(action)
    else
      title = action
    end

    icon = options.delete(:icon)
    icon ||= action

    type = options.delete(:type)
    classes << "btn-#{type}"

    options.merge!(:class => classes.join(" "))
    link_to(url_for(url), options) do
      content_tag(:i, "", :class => "icon-#{action_to_icon(icon)}") + " " + title
    end
  end

  def contextual_link_to(action, resource_or_model = nil, link_options = {})
    # We don't want to change the passed in link_options
    options = link_options.dup

    # Handle both symbols and strings
    action = action.to_sym

    # Resource and Model setup
    # Use controller name to guess resource or model if not specified
    case action
    when :new, :index
      model = resource_or_model || controller_name.singularize.camelize.constantize
    when :show, :edit, :delete
      resource = resource_or_model || instance_variable_get("@#{controller_name.singularize}")
      model = resource.class
    end
    model_name = model.to_s.underscore

    # No link if CanCan is used and current user isn't authorized to call this action
    return if respond_to?(:cannot?) and cannot?(action.to_sym, model)

    # Option generation
    case action
    when :delete
      options.merge!(:confirm => t_confirm_delete(resource), :method => :delete)
    end

    # Path generation
    case action
    when :index
      if model
        path = polymorphic_path(model)
      else
        path = url_for(:action => nil)
      end
    when :show, :delete
      if resource
        path = polymorphic_path(resource)
      else
        return
      end
    else
      if resource_or_model
        path = polymorphic_path(resource_or_model, :action => action)
      else
        path = url_for(:action => action)
      end
    end

    return icon_link_to(action, path, options)
  end

  def contextual_links_for(action = nil, resource_or_model = nil, options = {})
    # Use current action if not specified
    action ||= action_name

    # Handle both symbols and strings
    action = action.to_sym

    actions = []
    case action
    when :new, :create
      actions << :index
    when :show
      actions += [:edit, :delete, :index]
    when :edit, :update
      actions += [:show, :delete, :index]
    when :index
      actions << :new
    end

    links = actions.map{|action| contextual_link_to(action, resource_or_model, options)}

    return links.join("\n").html_safe
  end

  def contextual_links(action = nil, resource_or_model = nil, options = {})
    content_tag('div', :class => 'contextual') do
      contextual_links_for(action, resource_or_model, options)
    end
  end

  def contextual_aasms_to(resource_or_model = nil)
    model = resource_or_model || resource

    links = model.aasm.states.map do |state|
      if model.send("#{state}?")
        content_tag(:span, t_aasm(state), :class => "badge badge-success")
      else
        content_tag(:span, t_aasm(state), :class => "badge")
      end
    end

    if action_name == 'show'
      links += model.aasm.events.map do |event|
        classes = []
        link_to(url_for, :class => 'btn') do
          content_tag(:i) + action_name
        end
      end
    end

    return links.join("\n").html_safe
  end

  def contextual_aasms(resource_or_model = nil)
    content_tag('div', :class => 'state-bar') do
      contextual_aasms_to(resource_or_model)
    end
  end
end
