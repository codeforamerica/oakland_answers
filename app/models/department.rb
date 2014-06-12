class Department < ActiveRecord::Base
  attr_accessible :acronym, :name
  default_scope order('name ASC')
end
