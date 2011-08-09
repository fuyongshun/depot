class CommentsController < ApplicationController
    skip_before_filter :admin_authorize
    def create
      @product = Product.find(params[:product_id])
      @comment = @product.comments.create(params[:comment])
      @comment.user_id = session[:user_id]
      @comment.time = Time.now
      @comment.save
      redirect_to product_path(@product)
    end
    
    def destroy
      @product = Product.find(params[:product_id])
      @comment = @product.comments.find(params[:id])
      @comment.destroy
      redirect_to product_path(@product)
    end

end