class UsersController < ApplicationController
  skip_before_filter :authorize, :only => [:new, :create]
  skip_before_filter :admin_authorize, :only =>[:new, :create, :edit, :update, :show]
  # GET /users
  # GET /users.xml
  def index
    @users = User.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    if current_user and current_user.is_user
      redirect_to(current_user, :notice => "Not permission.")
      return
    end
    
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
    # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])
    
    # if the user has been login, that means he is admin
    unless login_as_admin
      @user.role = 'Register_User'
    end
    
    respond_to do |format|
      if @user.save
        # if the user has been login, that means he is admin
        unless login_as_admin
          session[:user_id] = @user.id
          format.html { redirect_to($last_url || store_url, 
            :notice => I18n.t('.signup')) }
          format.xml  { render :xml => @user, 
            :status => :created, :location => @user }
        end 
              
        format.html { redirect_to(users_path, 
          :notice => I18n.t('.user')+" #{@user.name} "+I18n.t('.success')) }
        format.xml  { render :xml => @user, 
          :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, 
          :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, 
          :notice => I18n.t('.user')+" #{@user.name} "+I18n.t('.success1')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])
    begin
    	@user.destroy
    	flash[:notice] = I18n.t('.user')+" #{@user.name} "+I18n.t('.delete')
    rescue Exception => e
    	flash[:notice] = e.message
    end

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
end
