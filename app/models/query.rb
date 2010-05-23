class Query < ActiveRecord::Base
  belongs_to :user
  has_many :mentions, :dependent => :destroy
  
  validates_presence_of :query
end
