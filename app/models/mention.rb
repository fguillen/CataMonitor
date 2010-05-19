class Mention < ActiveRecord::Base
  belongs_to :query
  
  named_scope :by_type, lambda { |mention_type| { :conditions => { :m_type => mention_type } } }
  
end
