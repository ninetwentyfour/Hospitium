class Admin::HomeController < Admin::ApplicationController

  def index
    @presenter = Admin::Home::IndexPresenter.new(current_user)

    send_stats

    @active_nav = true
  end

  private

  def send_stats
    return if [1,2].sample == 1
    threads = []

    threads << Thread.new do
      $statsd.gauge 'number_users', User.count
    end

    threads << Thread.new do
      $statsd.gauge 'number_animals', Animal.count
    end

    threads << Thread.new do
      $statsd.gauge 'number_organizations', Organization.count
    end

    threads << Thread.new do
      $statsd.gauge 'number_events', PublicActivity::Activity.count
    end

    threads.each { |thread| thread.join }
  end
end
