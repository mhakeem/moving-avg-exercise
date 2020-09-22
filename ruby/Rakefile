require "rake/testtask"

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
  t.pattern = 'spec/*_spec.rb'
end

task :default => :spec