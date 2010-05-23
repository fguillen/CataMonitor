require 'test_helper'

class MentionsControllerTest < ActionController::TestCase
  def setup
    activate_authlogic
    @user = Factory(:user)    
    @query = Factory(:query, :user => @user)
    UserSession.create(@user)
  end
  
  def test_by_type
    mention_blog_1 = Factory(:mention, :query => @query, :m_type => 'blogs' )
    mention_blog_2 = Factory(:mention, :query => @query, :m_type => 'blogs' )
    mention_news = Factory(:mention, :query => @query, :m_type => 'news' )
    
    get :by_type, :user_id => @user.id, :query_id => @query.id, :type => 'blogs'
    assert_template 'index'
    
    assert_equal( [mention_blog_1, mention_blog_2], assigns(:mentions) )
  end
  
  def test_by_type_with_days
    mention_less_days_1 = Factory(:mention, :query => @query, :m_type => 'blogs', :register_at => (Time.new - 1.days) )
    mention_less_days_2 = Factory(:mention, :query => @query, :m_type => 'blogs', :register_at => (Time.new - 2.days) )
    mention_less_days_3 = Factory(:mention, :query => @query, :m_type => 'news', :register_at => (Time.new - 3.days) )
    mention_less_days_4 = Factory(:mention, :query => @query, :m_type => 'blogs', :register_at => (Time.new - 4.days) )
    mention_less_days_5 = Factory(:mention, :query => @query, :m_type => 'blogs', :register_at => (Time.new - 5.days) )
    
    get :by_type, :user_id => @user.id, :query_id => @query.id, :type => 'blogs', :num_days => 4
    assert_template 'index'
    
    assert_equal( [mention_less_days_1, mention_less_days_2, mention_less_days_4], assigns(:mentions) )
  end
end
