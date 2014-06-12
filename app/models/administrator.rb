class Administrator < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
end
