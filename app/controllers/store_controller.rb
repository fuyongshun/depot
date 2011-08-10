class StoreController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :admin_authorize
  def index
    if params[:set_locale]
      redirect_to store_path(:locale => params[:set_locale])
    else
      if params[:category_id]
        if (Category.find(params[:category_id])[:parentid] == 0)
          categorys = Category.find(:all, :conditions => ['parentid = ?', params[:category_id]])
          cids = params[:category_id];
          categorys.each do |category|
            cids += ","+category.id.to_s
          end
          @products = Product.find(:all, :conditions => "category_id IN (#{cids})")
        else
          @products = Product.find(:all, :conditions => ['category_id = ?', params[:category_id]])
        end
      else
        @products = Product.all
      end
      @cart = current_cart
      @categories = Category.all
    end
  end

end
