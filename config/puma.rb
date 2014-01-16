threads 1,5
workers 2
preload_app!

on_worker_boot do
  ActiveRecord::Base.connection_pool.disconnect!

  ActiveSupport.on_load(:active_record) do
    config = Rails.application.config.database_configuration[Rails.env]
    config['reaping_frequency'] = ENV['DB_REAP_FREQ'] || 10 # seconds
    config['pool']              = ENV['DB_POOL']      || 10
    ActiveRecord::Base.establish_connection(config)
  end
end

on_restart do
  # Sidekiq.redis.shutdown { |conn| conn.close }
  # $redis_pool.shutdown { |conn| conn.close }
end