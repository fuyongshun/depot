class SearchesController < ApplicationController
  skip_before_filter :authorize  
  def index
    if params[:q]
      @results = Product.search(params[:q])
    end
  end
  
end
