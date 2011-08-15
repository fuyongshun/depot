class StarsController < ApplicationController
  skip_before_filter :authorize, :only => [:show]
  skip_before_filter :admin_authorize => [:show]
  
  # GET /stars
  # GET /stars.xml
  def index
    @stars = Star.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @stars }
    end
  end

  # GET /stars/1
  # GET /stars/1.xml
  def show
    @star = Star.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @star }
    end
  end

  # GET /stars/new
  # GET /stars/new.xml
  def new
     if (params[:ajax])
      newstar = {"product_id" => params[:product_id], "grade" => params[:grade], "user_id" => session[:user_id]}
      @star = Star.find(:last, :conditions => ['product_id = ? and user_id = ?', params[:product_id], session[:user_id]])
      if (@star)
        @star = Star.update(@star.id,newstar)
      else
        @star = Star.create(newstar)
      end
    else
      @star = Star.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @star }
      end
    end
  end

  # GET /stars/1/edit
  def edit
    @star = Star.find(params[:id])
  end

  # POST /stars
  # POST /stars.xml
  def create
    @star = Star.new(params[:star])

    respond_to do |format|
      if @star.save
        format.html { redirect_to(@star, :notice => I18n.t('.starsuccess')) }
        format.xml  { render :xml => @star, :status => :created, :location => @star }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /stars/1
  # PUT /stars/1.xml
  def update
    @star = Star.find(params[:id])

    respond_to do |format|
      if @star.update_attributes(params[:star])
        format.html { redirect_to(@star, :notice => I18n.t('.starsuccess1')) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @star.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /stars/1
  # DELETE /stars/1.xml
  def destroy
    @star = Star.find(params[:id])
    @star.destroy

    respond_to do |format|
      format.html { redirect_to(stars_url) }
      format.xml  { head :ok }
    end
  end
end
