class User < ActiveRecord::Base
  acts_as_authentic do |config|
    config.login_field = :email
  end
  
  has_many :queries
  validates_presence_of :contract_plan
  validates_presence_of :name
  
end
