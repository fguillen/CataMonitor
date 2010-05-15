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
    get :show, :id => Queries.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Queries.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Queries.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to queries_url(assigns(:queries))
  end
  
  def test_edit
    get :edit, :id => Queries.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Queries.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Queries.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Queries.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Queries.first
    assert_redirected_to queries_url(assigns(:queries))
  end
  
  def test_destroy
    queries = Queries.first
    delete :destroy, :id => queries
    assert_redirected_to queries_url
    assert !Queries.exists?(queries.id)
  end
end
