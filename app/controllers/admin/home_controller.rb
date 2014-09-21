class Admin::HomeController < Admin::ApplicationController

  def index
    @presenter = Admin::Home::IndexPresenter.new(current_user)

    # collect some stats for my dashbaord
    # Thread.new do
      $statsd.gauge 'number_users', User.count
      $statsd.gauge 'number_animals', Animal.count
      $statsd.gauge 'number_organizations', Organization.count
      $statsd.gauge 'number_events', PublicActivity::Activity.count
    # end

    @active_nav = true
  end
end