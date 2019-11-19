# sys reqs
# pdftotext
# sqlite

require 'active_support/all'
require 'benchmark'
require 'fileutils'
require 'csv'
require 'json'
require 'namae'
require 'nokogiri'
require 'pp'
require 'set'
require 'rest-client'
require 'street_address'
require 'tty-table'
require 'sqlite3'
require 'yaml'
require 'ostruct'

require_relative 'utils/csvs'
require_relative 'utils/hashes'
require_relative 'utils/logging'
require_relative 'utils/strings'
require_relative 'utils/files'
require_relative 'utils/jsons'
require_relative 'utils/sqls'
require_relative 'utils/pdfs'
require_relative 'utils/xmls'
require_relative 'utils/benchmarking'
require_relative 'utils/rollbar'
require_relative 'utils/aws'

require_relative 'data_handling/addresses'
require_relative 'data_handling/names'

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
