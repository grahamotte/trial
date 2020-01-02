require 'rubygems'
require 'bundler/setup'

# ruby / rails extensions

require 'active_support/all'
require 'benchmark'
require 'set'
require 'yaml'
require 'csv'

# trial extensions

require_relative 'trial/utils/csvs'
require_relative 'trial/utils/hashes'
require_relative 'trial/utils/logging'
require_relative 'trial/utils/strings'
require_relative 'trial/utils/files'
require_relative 'trial/utils/jsons'
require_relative 'trial/utils/sqls'
require_relative 'trial/utils/pdfs'
require_relative 'trial/utils/xmls'
require_relative 'trial/utils/benchmarking'
require_relative 'trial/utils/rollbar'
require_relative 'trial/utils/aws'
require_relative 'trial/utils/google_drive'
require_relative 'trial/data_handling/addresses'
require_relative 'trial/data_handling/names'

# secrets

if File.exists?('credentials.yml')
  CREDS = JSON.parse(
    YAML.load_file('credentials.yml').to_json,
    object_class: OpenStruct,
  )
end

# various

def or_nil
  val = yield
  raise if val.blank? || val == 0
  val
rescue StandardError
end

def float?(string)
  true if Float(string) rescue false
end

def aggressive_deep_symbolize_keys(maybe_arr)
  return maybe_arr.deep_symbolize_keys if maybe_arr.respond_to?(:deep_symbolize_keys)
  return maybe_arr.map { |i| aggressive_deep_symbolize_keys(i) } if maybe_arr.respond_to?(:each)

  maybe_arr
end
