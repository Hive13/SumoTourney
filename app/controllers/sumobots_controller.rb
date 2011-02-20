class SumobotsController < ApplicationController
  before_filter :authenticate_contender!, :except => [:show, :index]

  # GET /sumobots
  # GET /sumobots.xml
  def index
    @sumobots = Sumobot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sumobots }
    end
  end

  # GET /sumobots/1
  # GET /sumobots/1.xml
  def show
    @sumobot = Sumobot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sumobot }
    end
  end

  # GET /sumobots/new
  # GET /sumobots/new.xml
  def new
    @contender = 
    @sumobot = Sumobot.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sumobot }
    end
  end

  # GET /sumobots/1/edit
  def edit
    @sumobot = Sumobot.find(params[:id])
    if not @sumobot.contender_id == current_contender.id then
	redirect_to "/hax.html"
    end
  end

  # POST /sumobots
  # POST /sumobots.xml
  def create
    @sumobot = Sumobot.new(params[:sumobot])
    @sumobot.contender_id = current_contender.id

     respond_to do |format|
       if @sumobot.save
         format.html { redirect_to(@sumobot, :notice => 'Sumobot was successfully created.') }
         format.xml  { render :xml => @sumobot, :status => :created, :location => @sumobot }
       else
         format.html { render :action => "new" }
         format.xml  { render :xml => @sumobot.errors, :status => :unprocessable_entity }
       end
     end
  end

  # PUT /sumobots/1
  # PUT /sumobots/1.xml
  def update
    @sumobot = Sumobot.find(params[:id])

    respond_to do |format|
      if @sumobot.update_attributes(params[:sumobot])
        format.html { redirect_to(@sumobot, :notice => 'Sumobot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sumobot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sumobots/1
  # DELETE /sumobots/1.xml
  def destroy
    @sumobot = Sumobot.find(params[:id])
    if not @sumobot.contender_id == current_contender.id then
	redirect_to "/hax.html"
    else
        @sumobot.destroy
    end

    respond_to do |format|
      format.html { redirect_to(sumobots_url) }
      format.xml  { head :ok }
    end
  end
end
