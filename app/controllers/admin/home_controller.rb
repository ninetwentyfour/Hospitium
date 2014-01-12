class Admin::HomeController < Admin::ApplicationController

  def index
    @presenter = Admin::Home::IndexPresenter.new(current_user)

    # collect some stats for my dashbaord
    $statsd.gauge 'number_users', User.count
    $statsd.gauge 'number_animals', Animal.count
    $statsd.gauge 'number_organizations', Organization.count
    $statsd.gauge 'number_events', Event.count

    @active_nav = true
  end
end