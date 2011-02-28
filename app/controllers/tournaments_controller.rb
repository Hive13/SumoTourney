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

    @tournament.current_round = 1

    @max_matches = @bot_ids.size - 1
    assigned_matches = 0
    last_round_matches = Array.new
    current_round = 1

    respond_to do |format|
      if @tournament.save
        # Setups Round 1
        0.step((@bot_ids.size/2).round, 2).each do |id|
	   @match = Match.new(
		:first_bot_id => @bot_ids[id],
		:second_bot_id => @bot_ids[id+1],
		:round => current_round,
		:first_bot_round1_score => 0,
		:second_bot_round1_score => 0,
		:first_bot_round2_score => 0,
		:second_bot_round2_score => 0,
		:first_bot_round3_score => 0,
		:second_bot_round3_score => 0,
		:tournament_round => 1,
		:tournament_id => @tournament.id)
	   @match.save!
           assigned_matches += 1
           last_round_matches << @match.id
        end

        current_round = 2
        new_matches = Array.new

        if @bot_ids.size % 2 then  # Odd number
	   @match = Match.new(
		:first_bot_id => @bot_ids.last,
		:second_bot_from_match => last_round_matches.pop,
		:round => current_round,
		:first_bot_round1_score => 0,
		:second_bot_round1_score => 0,
		:first_bot_round2_score => 0,
		:second_bot_round2_score => 0,
		:first_bot_round3_score => 0,
		:second_bot_round3_score => 0,
		:tournament_round => 1,
		:tournament_id => @tournament.id)
	   @match.save!
           assigned_matches += 1
           new_matches << @match.id
	end

        while(last_round_matches.size > 1) do
	   @match = Match.new(
		:first_bot_from_match => last_round_matches.pop,
		:second_bot_from_match => last_round_matches.pop,
		:round => current_round,
		:first_bot_round1_score => 0,
		:second_bot_round1_score => 0,
		:first_bot_round2_score => 0,
		:second_bot_round2_score => 0,
		:first_bot_round3_score => 0,
		:second_bot_round3_score => 0,
		:tournament_round => 1,
		:tournament_id => @tournament.id)
	   @match.save!
           assigned_matches += 1
           new_matches << @match.id
	   if last_round_matches.size < 2 then
		last_round_matches += new_matches
		new_matches = Array.new
		current_round += 1
	   end
	end
	@tournament.update_attributes(:max_rounds => current_round)
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
