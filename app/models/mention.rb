class Mention < ActiveRecord::Base
  belongs_to :query
  
  named_scope :by_type, lambda { |mention_type| { :conditions => { :m_type => mention_type } } }
  named_scope :by_date, lambda { |date| { :conditions => ["CAST(register_at AS DATE) = ?", date.strftime('%Y-%m-%d')] } }
  named_scope :between_dates, lambda { |date_ini, date_end| { :conditions => ["CAST(register_at AS DATE) >= ? and CAST(register_at AS DATE) <= ?", date_ini.strftime('%Y-%m-%d'), date_end.strftime('%Y-%m-%d')] } }
  
  def self.chart_data( query, mention_type, date_end = Time.now, days = 30 )
    result = []
    
    (0..days).each do |days_less|
      date = (date_end.to_date - days_less.days).to_date
      result << [ date, query.mentions.by_type( mention_type ).by_date( date ).count ]
    end
    
    return result
  end
  
  def self.pie_data( query, date_end = Time.now, days = 30 )
    result = []
    %w(blogs microblogs bookmarks comments events images news videos audio questions networks).each do |mention_type|
      result << [mention_type.capitalize, query.mentions.by_type( mention_type ).between_dates( date_end - days.days, date_end ).count]
    end
    
    return result
  end
  
end
