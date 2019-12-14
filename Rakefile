require "rake/testtask"

Rake::TestTask.new(:spec) do |t|
  t.libs << "spec"
  t.libs << "lib"
#   t.test_files = FileList["spec/*_spec.rb", 'spec/spec.rb']
  t.pattern = 'spec/*_spec.rb'
  # t.verbose = true
end

task :default => :spec