if !ENV['RACK_ENV']
  ENV['RACK_ENV'] = 'development'
else
  valid_envs = %w[development production test]
  unless valid_envs.include?(ENV['RACK_ENV'])
    puts "Environment '#{ENV['RACK_ENV']}' is invalid, must be one of #{valid_env}"
    exit(1)
  end
end

require 'dotenv'

Dotenv.load('.env.development') if ENV['RACK_ENV'] == 'development'
Dotenv.load('.env.test') if ENV['RACK_ENV'] == 'test'

require 'zeitwerk'

Zeitwerk::Loader.new.tap do |loader|
  lib_path = File.expand_path('../lib', __dir__)
  loader.push_dir(lib_path)
  loader.setup

  loader.eager_load if ENV['RACK_ENV'] == 'production'
end

require 'date'
require 'securerandom'

require 'sinatra'
require 'graphql'
require 'mongo'
require 'json'

if ENV['RACK_ENV'] == 'development'
  require 'pry'
  require 'pry-byebug'
end

class AppEnvironment
  attr_reader :env

  ROOT_PATH = File.expand_path('../', __dir__)

  def self.instance
    @instance ||= new
  end

  def boot!
    raise 'App is already booted. Aborting.' if @booted

    @booted = true
    @env = ENV['RACK_ENV']

    load_config
    setup_db_connections
  end

  def setup_db_connections
    @mongo_conn = Mongo::Client.new(@mongo_url)
  end

  private

  def load_config
    @mongo_url = ENV['MONGO_URL']

    raise 'MONGO_URL env var must be a valid URL' if !@mongo_url || @mongo_url == ''
  end
end
