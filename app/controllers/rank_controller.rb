class RankController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :admin_authorize
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
		@stars = Star.find(:all, :group => "product_id", :order => "grade DESC")
		i=0;	
		
		@products = Array.new
		@stars.each do |star|
			@products[i] = (Product.find(:all, :conditions => ['id = ?', star.product_id]))[0]
			i+=1;
		end

		@products = @products.paginate :page => params[:page], :per_page => 5
		@cart = current_cart
		@categories = Category.all
    end
    render :layout => false
  end
end
