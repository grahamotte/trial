require 'rubygems'
require 'bundler/setup'

# ruby / rails extensions

require 'active_support/all'
require 'benchmark'
require 'set'
require 'yaml'
require 'csv'
require 'pp'

# trial extensions

require_relative 'trial/utils/various'
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
