require 'test_helper'

class MentionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Mention.new.valid?
  end
  
  def test_by_type
    query = Factory(:query)
    mention_blog_1 = Factory(:mention, :query => query, :m_type => 'blog' )
    mention_blog_2 = Factory(:mention, :query => query, :m_type => 'blog' )
    mention_news = Factory(:mention, :query => query, :m_type => 'news' )
    
    assert_equal( [mention_blog_1, mention_blog_2], query.mentions.by_type( 'blog' ) )
  end
  
  def test_by_date
    query = Factory(:query)
    mention_20100101_1 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-01 10:10:10') )
    mention_20100101_2 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-01 12:10:10') )
    mention_20100102 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-02 12:10:10') )
    
    assert_equal( [mention_20100101_1, mention_20100101_2], query.mentions.by_date( Time.parse('2010-01-01') ) )
  end
  
  def test_between_dates
    query = Factory(:query)
    mention_20100101_1 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-01 10:10:10') )
    mention_20100101_2 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-01 12:10:10') )
    mention_20100102 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-02 12:10:10') )
    mention_20100103 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-03 12:10:10') )
    mention_20100104 = Factory(:mention, :query => query, :register_at => Time.parse('2010-01-04 12:10:10') )
    
    assert_equal( [mention_20100102, mention_20100103], query.mentions.between_dates( Time.parse('2010-01-02'), Time.parse('2010-01-03') ) )
  end
  
  def test_chart_data
    query = Factory(:query)
    mention_20100101_1 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-01 10:10:10') )
    mention_20100101_2 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-01 12:10:10') )
    mention_20100102 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-02 12:10:10') )
    
    assert_equal( '[["2010-01-02",1],["2010-01-01",2],["2009-12-31",0],["2009-12-30",0]]', Mention.chart_data( query, 'blogs', Time.parse('2010-01-01 10:10:10') + 1.days, 3 ).to_json )
  end
  
  def test_pie_data
    query = Factory(:query)
    mention_20100101_1 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-01 10:10:10') )
    mention_20100101_2 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-01 12:10:10') )
    mention_20100102 = Factory(:mention, :query => query, :m_type => 'news', :register_at => Time.parse('2010-01-02 12:10:10') )
    mention_20100103 = Factory(:mention, :query => query, :m_type => 'news', :register_at => Time.parse('2010-01-03 12:10:10') )
    mention_20100104 = Factory(:mention, :query => query, :m_type => 'blogs', :register_at => Time.parse('2010-01-04 12:10:10') )
    
    assert_equal( 
      '[["Blogs",2],["Microblogs",0],["Bookmarks",0],["Comments",0],["Events",0],["Images",0],["News",2],["Videos",0],["Audio",0],["Questions",0],["Networks",0]]', 
      Mention.pie_data( query, Time.parse('2010-01-03'), 2 ).to_json
    )
    
  end
end
