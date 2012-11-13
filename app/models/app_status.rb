class AppStatus < ActiveRecord::Base
  validates :status, :inclusion => { :in => %w(UP DOWN), :message => "%{value} is not a valid status" }, :allow_nil => true
  validates :status, :presence => { :message => "status_message is required if no status is set" }, :if => Proc.new { |app_status| app_status.status_message.blank? }
  validates :status_message, :presence => { :message => "status_message is required if no status is set" }, :if => Proc.new { |app_status| app_status.status.blank? }
  
  before_save :set_status_if_no_status_given, :if => Proc.new { |app_status| app_status.status.blank? }

  attr_accessible :status, :status_message

  def pretty_timestamp
    self.created_at.strftime("%B %d, %Y %I:%M%p EST")
  end

  private

  def set_status_if_no_status_given
    last_status = AppStatus.last
    self.status = last_status.status unless last_status.nil?
  end  
end