class Query < ActiveRecord::Base
  belongs_to :user
  has_many :mentions
end
