class SessionsController < ApplicationController
  skip_before_filter :authorize
  skip_before_filter :admin_authorize
 
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sessions }
    end
  end

  def create
    if user = User.authenticate(params[:name], params[:password])
      session[:user_id] = user.id
      if user.is_admin
        redirect_to admin_url
      else
        redirect_to store_url, :notice => "Successfully login. Welcome."
      end
    else
      redirect_to login_url, :notice => I18n.t('.invalid')
    end
  end

  def destroy
    # cart = Cart.find(session[:cart_id])
    # cart.destroy
    session[:user_id] = nil
    redirect_to store_url, :notice=>I18n.t('.logout')
  end
  
  def sign_up
    redirect_to "/users/new"
  end

end
