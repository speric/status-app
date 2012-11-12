class AppStatus < ActiveRecord::Base
  validates :status, :inclusion => { :in => %w(UP DOWN), :message => "%{value} is not a valid status" }, :allow_nil => true
  
  before_save :set_status_if_no_status_given, :if => Proc.new { |app_status| app_status.status.blank? }

  private

  def set_status_if_no_status_given
    last_status = AppStatus.last
    self.status = last_status.status unless last_status.nil?
  end
end