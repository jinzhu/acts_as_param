require File.join(File.dirname(__FILE__), '../../../../lib/acts_as_param')

class Product < ActiveRecord::Base
  acts_as_param :serial, :name
end
