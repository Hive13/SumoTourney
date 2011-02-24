class TournamentsController < ApplicationController
  before_filter :authenticate_contender!, :except => [:show, :index]

  # GET /tournaments
  # GET /tournaments.xml
  def index
    @tournaments = Tournament.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tournaments }
    end
  end

  # GET /tournaments/1
  # GET /tournaments/1.xml
  def show
    @tournament = Tournament.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/new
  # GET /tournaments/new.xml
  def new
    @tournament = Tournament.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tournament }
    end
  end

  # GET /tournaments/1/edit
  def edit
    @tournament = Tournament.find(params[:id])
  end

  # POST /tournaments
  # POST /tournaments.xml
  def create
    @tournament = Tournament.new(params[:tournament])
    @competing = params[:competing]
    if cannot? :create, @tournament then
	redirect_to "/hax.html"
    end

    @bot_ids = Array.new
    @competing.each_key {|bot_id| @bot_ids << bot_id }

    @bot_ids.shuffle!
    matches = @bot_ids.size
    if @bot_ids.size % 2 then  # Odd Number
	matches -= 1
    end

    @tournament.current_round = 1

    respond_to do |format|
      if @tournament.save
        0.step(matches, 2).each do |id|
	   @match = Match.new(
		:first_bot_id => @bot_ids[id],
		:second_bot_id => @bot_ids[id+1],
		:round => 1,
		:first_bot_round1_score => 0,
		:second_bot_round1_score => 0,
		:first_bot_round2_score => 0,
		:second_bot_round2_score => 0,
		:first_bot_round3_score => 0,
		:second_bot_round3_score => 0,
		:tournament_round => 1,
		:tournament_id => @tournament.id)
	   @match.save!
        end

	if not matches == @bot_ids.size then
		@tournament.update_attributes(:benched_bot => @bot_ids.last)
	end
        format.html { redirect_to(@tournament, :notice => 'Tournament was successfully created.') }
        format.xml  { render :xml => @tournament, :status => :created, :location => @tournament }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tournaments/1
  # PUT /tournaments/1.xml
  def update
    @tournament = Tournament.find(params[:id])
    if cannot :update, @tournament then
	redirect_to "/hax.html"
    end

    respond_to do |format|
      if @tournament.update_attributes(params[:tournament])
        format.html { redirect_to(@tournament, :notice => 'Tournament was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tournaments/1
  # DELETE /tournaments/1.xml
  def destroy
    @tournament = Tournament.find(params[:id])

    if crannot? :manage, @tournament then
	redirect_to "/hax.html"
    end

    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to(tournaments_url) }
      format.xml  { head :ok }
    end
  end
end
