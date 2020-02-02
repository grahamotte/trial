Gem::Specification.new do |s|
  s.name = 'trials'
  s.authors = 'grahamotte'
  s.licenses = ['MIT']
  s.version = '0.0.7'
  s.date = '2020-01-01'
  s.summary = 'gem for testing out ideas quickly'
  s.executables << 'trial'
  s.files = ["lib/trials.rb"]
  s.files = Dir.glob("{bin,lib}/**/*")
  s.require_paths = ["lib"]

  s.add_dependency 'activesupport'
  s.add_dependency 'aws-sdk-dynamodb'
  s.add_dependency 'benchmark'
  s.add_dependency 'csv'
  s.add_dependency 'fileutils'
  s.add_dependency 'fuzzy_match'
  s.add_dependency 'google_drive'
  s.add_dependency 'json'
  s.add_dependency 'minitest'
  s.add_dependency 'namae'
  s.add_dependency 'nokogiri'
  s.add_dependency 'ostruct'
  s.add_dependency 'pry'
  s.add_dependency 'rake'
  s.add_dependency 'rest-client'
  s.add_dependency 'smalltext'
  s.add_dependency 'sqlite3'
  s.add_dependency 'street_address'
  s.add_dependency 'tty-table'
end
