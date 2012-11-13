require 'test_helper'

class StatusesControllerTest < ActionController::TestCase
  test "should get index with no errors" do
    get :index
    assert_response :success
    assert_not_nil assigns(:statuses)
  end
  
  test "should create a status with only status" do
    post :create, :app_status => { :status => "DOWN" }
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["status"], "DOWN"
  end

  test "should create a status with only status_message" do
    post :create, :app_status => { :status_message => "Chaos monkey on the loose" }
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["status_message"], "Chaos monkey on the loose"
  end

  test "should create a status with status and status_message" do
    post :create, :app_status => { :status => "UP", :status_message => "All systems go" }
    assert_response :success
    body = JSON.parse(response.body)
    assert_equal body["status"], "UP"
    assert_equal body["status_message"], "All systems go"
  end

  test "should not create a status with an invalid status value" do
    post :create, :app_status => { :status => "SIDEWAYS", :status_message => "Things are falling apart." }
    assert_response :unprocessable_entity
    body = JSON.parse(response.body)
    assert_equal body["errors"]["status"].first, "SIDEWAYS is not a valid status"
  end

  test "should not create a status with neither status nor status_message" do
    post :create
    assert_response :unprocessable_entity
    body = JSON.parse(response.body)
    assert_equal body["errors"]["status"].first, "status is required if no status_message is set"
  end
end
