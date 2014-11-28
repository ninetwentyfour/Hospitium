module ApplicationHelper
  
  def calculate_animal_age(birthday)
    age = (Time.now.year - birthday.year).to_s + " years"
    if age == "0 years"
      age = (Time.now.month - birthday.month).to_s + " months"
      if age == "0 months"
        age = (Time.now.day - birthday.day).to_s + " days"
      end
    end
    return age
  end
  
  def canonical_link_tag
    tag(:link, :rel => :canonical, :href => "https://hospitium.co#{@canonical_url}") if @canonical_url
  end
  
  def current_class?(con, act)
    if current_page?(:controller => con, :action => act)
      return 'active' 
    else
     return ''
    end
  end
  
  def markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
        :hard_wrap => true, :filter_html => true),
        :no_intraemphasis => true, :autolink => true)
    return markdown.render(sanitize(text)).html_safe
  end

  def unsafe_markdown(text)
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(
        :hard_wrap => true),
        :no_intraemphasis => true, :autolink => true)
    return markdown.render(sanitize(text)).html_safe
  end
  
  def is_table_view(params)
    params.merge({:table_view => 'true'}) if params[:table_view]
  end
  
  def table_view_button(params)
    params[:table_view] ? params.merge(:table_view => nil) : params.merge(:table_view => "true")
  end

  def table_button_text(params)
    params[:table_view] ? '<i class="fa fa-th-large tipster" title="Card View"></i><span class="hidden-xs hidden-sm"> Card View</span>' : '<i class="fa fa-table tipster" title="Table View"></i><span class="hidden-xs hidden-sm"> Table View</span>'
  end

  def archived_view_button(params)
    params[:archived_view] ? params.merge(:archived_view => nil) : params.merge(:archived_view => "true")
  end

  def archived_button_text(params)
    params[:archived_view] ? '<i class="fa fa-archive tipster" title="Hide Archived"></i> <span class="hidden-xs hidden-sm">Hide Archived</span>' : '<i class="fa fa-archive tipster" title="View Archived"></i> <span class="hidden-xs hidden-sm">View Archived</span>'
  end

  def past_tense_actions(action)
    case action
    when 'create'
      'created'
    when 'update'
      'updated'
    when 'destroy'
      'destroyed'
    end
  end

  def indefinite_articlerize(params_word)
      %w(a e i o u).include?(params_word[0].downcase) ? "an #{params_word}" : "a #{params_word}"
  end

  def public_activity_icon(action)
    case action
    when 'create'
      'fa fa-plus green'
    when 'update'
      'fa fa-pencil green'
    when 'destroy'
      'fa fa-trash red'
    end      
  end
end
