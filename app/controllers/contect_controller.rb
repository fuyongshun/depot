class ContectController < ApplicationController
  skip_before_filter :authorize  
  skip_before_filter :admin_authorize 
  def index
  	render :layout => false
  end
end
