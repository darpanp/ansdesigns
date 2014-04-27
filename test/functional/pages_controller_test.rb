require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "should show home" do
    get :home
    assert_response :success
    assert_template 'home'
  end
  
  test "should show about" do
    get :about
    assert_response :success
    assert_template 'about'
  end
  
  test "should show projects" do
    get :projects
    assert_response :success
    assert_template 'projects'
  end
  
  test "should show contacts" do
    get :contacts
    assert_response :success
    assert_template 'contacts'
  end
  
  test "should show quote" do
    get :quote
    assert_response :success
    assert_template 'quote'
  end
  
  test "should show register" do
    get :register
    assert_response :success
    assert_template 'register'
  end
end
