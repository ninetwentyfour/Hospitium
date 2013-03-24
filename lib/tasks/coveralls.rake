unless Rails.env.production?
  require 'coveralls/rake/task'
  Coveralls::RakeTask.new
  task :test_with_coveralls => [:spec, :cucumber, 'coveralls:push']
end