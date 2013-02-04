# $statsd = Statsd.new '127.0.0.1', 8125
# # Set the namespace to admin
# $statsd.namespace = "hospitium"

# Setup statsd for use throughout app

# Listen to all action controller events
ActiveSupport::Notifications.subscribe /process_action.action_controller/ do |*args| 
  event = ActiveSupport::Notifications::Event.new(*args)
  controller = event.payload[:controller]
  action = event.payload[:action]
  format = event.payload[:format] || "all" 
  format = "all" if format == "*/*" 
  status = event.payload[:status]
  key = "#{controller}.#{action}.#{format}.#{ENV["INSTRUMENTATION_HOSTNAME"]}" 
  ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.total_duration", :value => event.duration
  ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.db_time", :value => event.payload[:db_runtime]
  ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.view_time", :value => event.payload[:view_runtime]
  ActiveSupport::Notifications.instrument :performance, :measurement => "#{key}.status.#{status}" 
end

# Send all those events to statsd
def send_event_to_statsd(name, payload)
  action = payload[:action] || :increment
  measurement = payload[:measurement]
  value = payload[:value]
  key_name = "#{name.to_s.capitalize}.#{measurement}"
  $statsd.__send__ action.to_s, key_name, (value || 1)
end

ActiveSupport::Notifications.subscribe /performance/ do |name, start, finish, id, payload|
  send_event_to_statsd(name, payload)
end