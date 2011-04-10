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
    @competing.each_key {|bot_id| @bot_ids << bot_id if @competing[bot_id] == "1"}

    @bot_ids.shuffle!

    @tournament.current_round = 1

    respond_to do |format|
      if @tournament.save
        current_round = build_blank_tournament(@bot_ids.size, @tournament.id)
	current_round+=1
        assign_round1(@tournament.id, @bot_ids)
	@tournament.update_attributes(:max_rounds => current_round)
        format.html { redirect_to(@tournament, :notice => 'Tournament was successfully created.') }
        format.xml  { render :xml => @tournament, :status => :created, :location => @tournament }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tournament.errors, :status => :unprocessable_entity }
      end
    end
  end

  # Creates an empty tournament
  def build_blank_tournament(num_bots, t_id)
	round = 1
	(1..num_bots/2).each do |bot_cnt|
	   build_blank_match(round, t_id)
	end
	if num_bots % 2 == 1 then # odd
	   build_blank_match(round, t_id, true)
	end
        done = false
	while(!done)
	  matches_assigned = build_next_blank_round(round, t_id)
	  round += 1
	  done = true if matches_assigned < 2
	end
	return round
  end

  # Build a blank round
  def build_next_blank_round(last_round, t_id)
     matches_assigned = 0
     current_round = last_round + 1
     last_round = Match.find(:all, :conditions => {:tournament_id => t_id, :tournament_round => last_round})
     num_bots = last_round.size
	(1..num_bots/2).each do |bot_cnt|
	   build_blank_match(current_round, t_id)
           matches_assigned += 1
	end
	if num_bots % 2 == 1 then # odd
	   build_blank_match(current_round, t_id, true)
           matches_assigned += 1
	end
        current_round = Match.find(:all, :conditions => {:tournament_id => t_id, :tournament_round => current_round})
        current_round.each do |match|
	  if match.first_bot_from_match == 0 then
	    match.update_attributes(:first_bot_from_match => last_round.pop.id)
	  end
	  if match.second_bot_from_match == 0 then
	    match.update_attributes(:second_bot_from_match => last_round.pop.id)
	  end
	end
      return matches_assigned
  end

  # Builds a single blank match.  If bye is true then creates a -1 for second bot
  def build_blank_match(current_round, t_id, bye=false)
   second_bot = (bye ? -1 : 0)
   @match = Match.new(
	:first_bot_from_match => 0,
  	:second_bot_from_match => second_bot,
	:round => 1,
	:first_bot_round1_score => 0,
	:second_bot_round1_score => 0,
	:first_bot_round2_score => 0,
	:second_bot_round2_score => 0,
	:first_bot_round3_score => 0,
	:second_bot_round3_score => 0,
	:tournament_round => current_round,
	:tournament_id => t_id)
   @match.save
  end

  # Assigns bots to first round
  def assign_round1(t_id, bots)
    matches = Match.find(:all, :conditions => {:tournament_id => t_id, :tournament_round => 1})
    matches.each do |match|
	if match.first_bot_from_match == 0 then
	  bot_id = bots.pop
	  match.update_attributes(:first_bot_id => bot_id)
	end
	if match.second_bot_from_match == 0 then
	  bot_id = bots.pop
	  match.update_attributes(:second_bot_id => bot_id)
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

    if cannot? :manage, @tournament then
	redirect_to "/hax.html"
    end

    @tournament.destroy

    respond_to do |format|
      format.html { redirect_to(tournaments_url) }
      format.xml  { head :ok }
    end
  end
end
