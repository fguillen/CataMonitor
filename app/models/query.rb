class Query < ActiveRecord::Base
  belongs_to :user
  has_many :mentions
  
  validates_presence_of :query
end
