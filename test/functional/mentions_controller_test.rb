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
end
