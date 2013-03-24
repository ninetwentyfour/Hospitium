class Admin::HomeController < Admin::ApplicationController

  def index
    @presenter = Admin::Home::IndexPresenter.new(current_user)
    
    @status_chart = Report.new_chart(current_user.organization_id, "status")

    @species_chart = Report.new_chart(current_user.organization_id, "species")

    @colors_chart = Report.new_chart(current_user.organization_id, "animal_color")

    # collect some stats for my dashbaord
    $statsd.gauge 'number_users', User.count
    $statsd.gauge 'number_animals', Animal.count
    $statsd.gauge 'number_organizations', Organization.count
    $statsd.gauge 'number_events', Event.count
  end
  
end