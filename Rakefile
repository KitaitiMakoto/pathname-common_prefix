require 'rake/testtask'
require 'rubygems/tasks'

task :default => [:test, :typecheck]

Rake::TestTask.new
Gem::Tasks.new

task :typecheck do
  sh "steep check"
end
