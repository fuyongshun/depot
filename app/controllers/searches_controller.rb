class SearchesController < ApplicationController
  skip_before_filter :authorize  
  skip_before_filter :admin_authoriz  
  def index
    if params[:q]
      @results = Product.search(params[:q])
    end
  end
  
end
