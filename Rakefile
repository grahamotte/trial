require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << %w(test lib)
  t.test_files = FileList['test/**/*_test.rb']
end

desc "Push gem"
task :release do
  system('bump patch')
  system('gem build trials.gemspec --output trials.gem')
  system('gem push trials.gem')
end
