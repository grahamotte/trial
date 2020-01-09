Gem::Specification.new do |s|
  s.name = 'trials'
  s.authors = 'grahamotte'
  s.licenses = ['MIT']
  s.version = '0.0.1'
  s.date = '2020-01-01'
  s.summary = 'gem for testing out ideas quickly'
  s.executables << 'trial'
  s.files = [
    "Gemfile",
    "Rakefile",
    "lib/trial.rb"
  ]
  s.files = Dir.glob("{bin,lib}/**/*")
  s.require_paths = ["lib"]

  s.add_runtime_dependency 'activesupport'
  s.add_runtime_dependency 'benchmark'
  s.add_runtime_dependency 'fileutils'
  s.add_runtime_dependency 'csv'
  s.add_runtime_dependency 'json'
  s.add_runtime_dependency 'namae'
  s.add_runtime_dependency 'nokogiri'
  s.add_runtime_dependency 'rest-client'
  s.add_runtime_dependency 'street_address'
  s.add_runtime_dependency 'tty-table'
  s.add_runtime_dependency 'sqlite3'
  s.add_runtime_dependency 'ostruct'
  s.add_runtime_dependency 'google_drive'
  s.add_runtime_dependency 'aws-sdk-dynamodb'
  s.add_runtime_dependency 'fuzzy_match'
  s.add_runtime_dependency 'minitest'
  s.add_runtime_dependency 'rake'
  s.add_runtime_dependency 'pry'
  s.add_runtime_dependency 'smalltext'
end
