class StatusesController < ApplicationController
  
  def index
    @statuses = AppStatus.limit(11).order("created_at desc")
  end
  
  def create 
    @status = AppStatus.new(params[:app_status])
    if @status.save
      render :json => {:app_status => @status}, :status => 200
    else
      render :json => {:errors => @status.errors}, :status => 422
    end
  end
end