class Product < ActiveRecord::Base
  acts_as_param :serial, :name
end
