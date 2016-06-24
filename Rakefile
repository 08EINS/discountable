require 'rake'
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

# This is taken from https://gist.github.com/drogus/6087979, thanks go to drogus
require 'bundler/setup'
require 'active_record'

include ActiveRecord::Tasks

module Rails
  def self.root
    File.dirname(__FILE__)
  end
end

db_dir = File.expand_path('../db', __FILE__)
config_dir = File.expand_path('../config', __FILE__)

DatabaseTasks.env = ENV['ENV'] || 'test'
DatabaseTasks.db_dir = db_dir
DatabaseTasks.database_configuration = YAML.load(File.read(File.join(config_dir, 'database.yml')))
DatabaseTasks.migrations_paths = File.join(db_dir, 'migrate')

task :environment do
  ActiveRecord::Base.configurations = DatabaseTasks.database_configuration
  ActiveRecord::Base.establish_connection DatabaseTasks.env
end

load 'active_record/railties/databases.rake'

RSpec::Core::RakeTask.new(:test) do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.verbose = true
end

task :default => [:test]