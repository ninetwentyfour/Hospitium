Rake::Task["assets:precompile:nondigest"].enhance do
  Rake::Task["assets:environment"].invoke if Rake::Task.task_defined?("assets:environment")
  AssetSync.sync
end