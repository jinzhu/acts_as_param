require File.expand_path(File.dirname(__FILE__) + '/app_root/config/environment')
require 'test_help'

# Run the migrations
ActiveRecord::Migration.verbose = false
ActiveRecord::Migrator.migrate("#{PLUGIN_RAILS_ROOT}/db/migrate")
