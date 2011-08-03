class SearchesController < ApplicationController
    
  def index
    if params[:q]
      @results = Product.search(params[:q])
    end
  end
  
end
