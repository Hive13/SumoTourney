class MatchesController < ApplicationController
  before_filter :authenticate_contender!, :except => [:show, :index]

  # GET /matches
  # GET /matches.xml
  def index
    @matches = Match.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @matches }
    end
  end

  # GET /matches/1
  # GET /matches/1.xml
  def show
    @match = Match.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/new
  # GET /matches/new.xml
  def new
    @match = Match.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @match }
    end
  end

  # GET /matches/1/edit
  def edit
    @match = Match.find(params[:id])
    if cannot? :update, @match
	redirect_to "/hax.html"
    end
  end

  # POST /matches
  # POST /matches.xml
  def create
    @match = Match.new(params[:match])
    if cannot? :create, @match
	redirect_to "/hax.html"
    end
    @match.round = 1
    @match.first_bot_round1_score = 0
    @match.first_bot_round2_score = 0
    @match.first_bot_round3_score = 0
    @match.second_bot_round1_score = 0
    @match.second_bot_round2_score = 0
    @match.second_bot_round3_score = 0

    respond_to do |format|
      if @match.save
        format.html { redirect_to(@match, :notice => 'Match was successfully created.') }
        format.xml  { render :xml => @match, :status => :created, :location => @match }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /matches/1
  # PUT /matches/1.xml
  def update
    @match = Match.find(params[:id])

    respond_to do |format|
      if @match.update_attributes(params[:match])
        format.html { redirect_to(@match, :notice => 'Match was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @match.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /matches/1
  # DELETE /matches/1.xml
  def destroy
    @match = Match.find(params[:id])
    if cannot? :update, @match
	redirect_to "/hax.html"
    else
    	@match.destroy
    end

    respond_to do |format|
      format.html { redirect_to(matches_url) }
      format.xml  { head :ok }
    end
  end

  def start_round
    @match = Match.find(params[:id])

    if cannot? :manage, @match then
	redirect_to "/hax.html"
    end

    @match.update_attributes(:start => Time.now.utc)

    respond_to do |format|
        format.html { redirect_to(@match) }
        format.xml { head :ok }
    end
  end

  def grant_point
    @bot = Sumobot.find(params[:bot_id])
    @match = Match.find(params[:id])
    
    if cannot? :manage, @match then
	redirect_to "/hax.html"
    end

    if not @match.start
      respond_to do |format|
        format.html { redirect_to(@match, :notice => 'You must first start the round!') }
        format.xml  { render :xml => "error" , :status => "Round not started" }
      end
      return
    end

    round = @match.round
    if @match.first_bot_id == @bot.id then
	case round
	when 1 then
		@match.update_attributes(:first_bot_round1_score => 1)
	when 2 then
		@match.update_attributes(:first_bot_round2_score => 1)
	when 3 then
		@match.update_attributes(:first_bot_round3_score => 1)
	end
    elsif @match.second_bot_id == @bot.id then
	case round
	when 1 then
		@match.update_attributes(:second_bot_round1_score => 1)
	when 2 then
		@match.update_attributes(:second_bot_round2_score => 1)
	when 3 then
		@match.update_attributes(:second_bot_round3_score => 1)
	end
    end

    if @match.bot1_final_score == 2 or
       @match.bot2_final_score == 2 then
	 @match.update_attributes(:winning_bot => @bot.id)
	 if @match.tournament_id then
	   nextmatch = Match.find(:first, :conditions => {:first_bot_from_match => @match.id})
	   if nextmatch then
		nextmatch.update_attributes(:first_bot_id => @bot.id)
	   else
	   	nextmatch = Match.find(:first, :conditions => {:second_bot_from_match => @match.id})
		if nextmatch then
			nextmatch.update_attributes(:second_bot_id => @bot.id)
		else
			puts "TODO: Game done, assign winnners"
		end
	   end
	 end	
    else
	@match.update_attributes(:round => round + 1, :start => nil)
    end

    respond_to do |format|
        format.html { redirect_to(@match) }
        format.xml { head :ok }
    end

  end
end
