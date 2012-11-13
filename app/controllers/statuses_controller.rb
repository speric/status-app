class StatusesController < ApplicationController
  
  def index
    @statuses = AppStatus.limit(11).order("created_at desc")
  end
  
  def create 
    @status = AppStatus.new(params[:app_status])
    if @status.save
      render :json => @status.to_json, :status => 200
    else
      render :json => {:errors => @status.errors}, :status => 422
    end
  end
end