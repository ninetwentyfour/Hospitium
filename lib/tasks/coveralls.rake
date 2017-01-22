unless Rails.env.production?
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  # task :test_with_coveralls => [:spec, :cucumber, 'coveralls:push']
  task test_with_coveralls: [:spec, 'coveralls:push']
end
