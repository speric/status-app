class AppStatus < ActiveRecord::Base
  validates :status, :inclusion => { :in => %w(UP DOWN), :message => "%{value} is not a valid status" }, :allow_nil => true
  validates :status, :presence => { :message => "status or status_message is required" }, :if => Proc.new { |app_status| app_status.status_message.blank? }

  before_save :use_last_status_if_no_status_given, :if => Proc.new { |app_status| app_status.status.blank? }

  attr_accessible :status, :status_message

  def pretty_timestamp
    self.created_at.strftime("%B %d, %Y %I:%M%p EST")
  end

  private

  def use_last_status_if_no_status_given
    self.status = AppStatus.last.status
  end  
end