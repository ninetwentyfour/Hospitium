# Role model
class Role < ActiveRecord::Base
  has_many :permissions
  has_many :users, through: :permissions # use join table permissions

  attr_accessible :name
end
