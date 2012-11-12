class StatusController < ApplicationController
  
  def index
    @statuses = AppStatus.limit(11).order("created_at desc")
  end
end