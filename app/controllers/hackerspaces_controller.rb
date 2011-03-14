class HackerspacesController < ApplicationController
  before_filter :authenticate_contender!, :except => [:show, :index]

  # GET /hackerspaces
  # GET /hackerspaces.xml
  def index
    @hackerspaces = Hackerspace.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @hackerspaces }
    end
  end

  # GET /hackerspaces/1
  # GET /hackerspaces/1.xml
  def show
    @hackerspace = Hackerspace.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @hackerspace }
    end
  end

  # GET /hackerspaces/new
  # GET /hackerspaces/new.xml
  def new
    @hackerspace = Hackerspace.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @hackerspace }
    end
  end

  # GET /hackerspaces/1/edit
  def edit
    @hackerspace = Hackerspace.find(params[:id])
  end

  # POST /hackerspaces
  # POST /hackerspaces.xml
  def create
    @hackerspace = Hackerspace.new(params[:hackerspace])
    @hackerspace.contender_id = current_contender.id

    respond_to do |format|
      if @hackerspace.save
        format.html { redirect_to(@hackerspace, :notice => 'Hackerspace was successfully created.') }
        format.xml  { render :xml => @hackerspace, :status => :created, :location => @hackerspace }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @hackerspace.errors, :status => :unprocessable_entity }
      end
    end
  end

  def join
    @hackerspace = Hackerspace.find(params[:id])
    @contender = Contender.find(current_contender.id)
    @contender.hackerspace_id = @hackerspace.id
    @contender.save!
    
    respond_to do |format|
     format.html { redirect_to(edit_contender_registration_path, :notice => "Joined #{@hackerspace.name}") }
     format.xml { head :ok }
    end
  end

  # PUT /hackerspaces/1
  # PUT /hackerspaces/1.xml
  def update
    @hackerspace = Hackerspace.find(params[:id])

    respond_to do |format|
      if @hackerspace.update_attributes(params[:hackerspace])
        format.html { redirect_to(@hackerspace, :notice => 'Hackerspace was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @hackerspace.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hackerspaces/1
  # DELETE /hackerspaces/1.xml
  def destroy
    @hackerspace = Hackerspace.find(params[:id])
    @hackerspace.destroy

    respond_to do |format|
      format.html { redirect_to(hackerspaces_url) }
      format.xml  { head :ok }
    end
  end
end
