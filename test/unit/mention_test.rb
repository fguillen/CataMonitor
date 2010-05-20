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
end
