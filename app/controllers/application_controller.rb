class ApplicationController < ActionController::Base
  before_filter :authorize
  before_filter :admin_authorize
  before_filter :store_location
  before_filter :set_i18n_locale_from_params
  protect_from_forgery
  
  private  
    def current_cart
      Cart.find(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end

  def current_user
      User.find_by_id(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      return nil
    end

  protected
  
    # Login according to permission
    def login_as_common_user
      if current_user
        return current_user.is_user
      end
      return false
    end
    
    def login_as_admin
      if current_user
        return current_user.is_admin
      end
      return false
    end
    #------------------------------
    

    def authorize
      unless current_user
        redirect_to login_url, :notice => I18n.t('.plog')
      end
    end
    
    def admin_authorize
      unless login_as_admin
        redirect_to store_url, :notice => I18n.t('.nopermission')
      end
    end

  	
  	def store_location
      if request.get? and controller_name != "users" and controller_name != "sessions"    
        $last_url = request.url
      end
    end 
  	
  	def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.include?(params[:locale].to_sym)
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{params[:locale]} translation not available"
          logger.error flash.now[:notice]
        end
      end
    end
  
  def default_url_options
    { :locale => I18n.locale }
  end
end
