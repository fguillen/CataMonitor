class Mention < ActiveRecord::Base
  belongs_to :query
  
  named_scope :by_type, lambda { |mention_type| { :conditions => { :m_type => mention_type } } }
  named_scope :by_date, lambda { |date| { :conditions => ["CAST(register_at AS DATE) = ?", date.strftime('%Y-%m-%d')] } }
  
end
