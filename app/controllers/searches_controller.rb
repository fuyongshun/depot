class SearchesController < ApplicationController
  skip_before_filter :authorize  
  skip_before_filter :admin_authorize  
  def index
    if params[:q]
      @results = Product.search(params[:q])
    end
    render :layout => false
  end
  
end
