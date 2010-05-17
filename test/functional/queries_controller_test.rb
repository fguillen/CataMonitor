require 'test_helper'

class QueriesControllerTest < ActionController::TestCase
  def setup
    activate_authlogic
    @user = Factory(:user)    
    UserSession.create(@user)
  end
  
  def test_index
    3.times{ Factory(:query, :user => @user) }
    get :index, :user_id => @user.id
    assert_template 'index'
    assert_equal( 3, assigns(:queries).size )
    assert_match( Query.first.query, @response.body )
  end
  
  def test_show
    query = Factory(:query, :user => @user)
    get :show, :user_id => @user.id, :id => query.id
    assert_template 'show'
    assert_match( query.query, @response.body )
  end
  
  def test_new
    get :new, :user_id => @user.id
    assert_template 'new'
  end
  
  def test_create_invalid
    Query.any_instance.stubs(:valid?).returns(false)
    post :create, :user_id => @user.id
    assert_template 'new'
    assert_not_nil( flash[:alert] )
  end
  
  def test_create
    assert_difference "Query.count", 1 do
      post :create, :user_id => @user.id, :query => { :query => 'the query' }      
    end

    assert_redirected_to user_query_url( @user, assigns(:query) )
    assert_equal( 'the query', Query.last.query )
  end
  
  def test_edit
    query = Factory(:query, :user => @user)
    get :edit, :user_id => @user.id, :id => query.id
    assert_template 'edit'
  end
  
  def test_update_invalid
    query = Factory(:query, :user => @user)
    Query.any_instance.stubs(:valid?).returns(false)
    put :update, :user_id => @user.id, :id => query.id
    assert_template 'edit'
    assert_not_nil( flash[:alert] )
  end
  
  def test_update_valid
    query = Factory(:query, :user => @user, :query => 'old query')
    Query.any_instance.stubs(:valid?).returns(true)
    put :update, :user_id => @user.id, :id => query.id, :query => { :query => 'new query' }
    assert_redirected_to user_query_url( @user, query )
    query.reload
    assert_equal( 'new query', query.query )
  end
  
  def test_destroy
    query = Factory(:query, :user => @user)
    delete :destroy, :user_id => @user.id, :id => query.id
    assert_redirected_to user_queries_url( @user )
    assert !Query.exists?(query.id)
  end
end
