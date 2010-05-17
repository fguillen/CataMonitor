require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    activate_authlogic
    @user = Factory(:user)    
    UserSession.create(@user)
  end
  
  def test_index
    3.times{ Factory(:user) }
    get :index
    assert_template 'index'
    assert_equal( 4, assigns(:users).size )
    assert_match( User.first.name, @response.body )
  end
  
  def test_show
    user = Factory(:user)
    get :show, :id => user.id
    assert_template 'show'
    assert_match( user.name, @response.body )
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    User.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
    assert_not_nil( flash[:alert] )
  end
  
  def test_create
    user_attributes = Factory.attributes_for(:user)
    assert_difference "User.count", 1 do
      post :create, :user => user_attributes
    end

    assert_redirected_to user_path( assigns(:user) )
    assert_equal( user_attributes[:name], User.last.name )
    assert_equal( user_attributes[:email], User.last.email )
    assert_equal( user_attributes[:contract_plan], User.last.contract_plan )
  end
  
  def test_edit
    user = Factory(:user)
    get :edit, :id => user.id
    assert_template 'edit'
  end
  
  def test_update_invalid
    user = Factory(:user)
    User.any_instance.stubs(:valid?).returns(false)
    put :update, :id => user.id
    assert_template 'edit'
    assert_not_nil( flash[:alert] )
  end
  
  def test_update_valid
    user = Factory(:user, :name => 'old name')
    put :update, :id => user.id, :user => { :name => 'new name' }
    assert_redirected_to user_url( user )
    user.reload
    assert_equal( 'new name', user.name )
  end
  
  def test_destroy
    user = Factory(:user)
    delete :destroy, :id => user.id
    assert_redirected_to users_url
    assert !User.exists?(user.id)
  end
end
