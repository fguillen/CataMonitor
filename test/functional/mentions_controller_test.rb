require 'test_helper'

class MentionsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Mention.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Mention.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Mention.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to mention_url(assigns(:mention))
  end
  
  def test_edit
    get :edit, :id => Mention.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Mention.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Mention.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Mention.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Mention.first
    assert_redirected_to mention_url(assigns(:mention))
  end
  
  def test_destroy
    mention = Mention.first
    delete :destroy, :id => mention
    assert_redirected_to mentions_url
    assert !Mention.exists?(mention.id)
  end
end
