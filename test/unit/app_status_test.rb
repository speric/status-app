require 'test_helper'
# ruby -Itest test/unit/app_status_test.rb

class AppStatusTest < ActiveSupport::TestCase
  test "new status with a status and message is valid" do
    app_status = AppStatus.new(:status => "UP", :status_message => "24 hrs of uptime")
    assert app_status.save
  end

  test "new status with an UP status and no message is valid" do
    app_status = AppStatus.new(:status => "UP")
    assert app_status.save
  end

  test "new status with a DOWN status and no message is valid" do
    app_status = AppStatus.new(:status => "DOWN")
    assert app_status.save
  end

  test "new status with an invalid status and no message is valid" do
    app_status = AppStatus.new(:status => "SIDEWAYS")
    assert !app_status.save
  end

  test "new status with no status and a status message is valid" do
    app_status = AppStatus.new(:status_message => "48 hrs of uptime")
    assert app_status.save
  end

  test "new status with no status no status message is invalid" do
    app_status = AppStatus.new
    assert !app_status.save
  end
end