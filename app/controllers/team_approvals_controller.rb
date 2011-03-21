class TeamApprovalsController < ApplicationController
  before_filter :authenticate_contender!

  # GET /team_approvals
  # GET /team_approvals.xml
  def index
    @team_approvals = TeamApproval.all

    if cannot? :index, TeamApproval then
	redirect_to "/hax.html"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @team_approvals }
    end
  end

  # GET /team_approvals/1
  # GET /team_approvals/1.xml
  def show
    @team_approval = TeamApproval.find(params[:id])

    if cannot? :show, TeamApproval then
	redirect_to "/hax.html"
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @team_approval }
    end
  end

  # GET /team_approvals/new
  # GET /team_approvals/new.xml
  def new
    @team = Team.find(params[:team_id])
    @team_approval = TeamApproval.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @team_approval }
    end
  end

  # GET /team_approvals/1/edit
  def edit
    @team_approval = TeamApproval.find(params[:id])
    if cannot? :manage, :all then
	redirect_to "/hax.html"
    end
  end

  # POST /team_approvals
  # POST /team_approvals.xml
  def create
    @team = Team.find(params[:team_id])
    @team_approval = TeamApproval.new(params[:team_approval])

    @team_approval.team_id = @team.id
    @team_approval.status = "apply"
    @team_approval.from_contender = current_contender.id
    @team_approval.to_contender = @team.contender_id

    respond_to do |format|
      if @team_approval.save
        format.html { redirect_to(@team_approval, :notice => 'Team approval was successfully created.') }
        format.xml  { render :xml => @team_approval, :status => :created, :location => @team_approval }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @team_approval.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /team_approvals/1
  # PUT /team_approvals/1.xml
  def update
    @team_approval = TeamApproval.find(params[:id])

    respond_to do |format|
      if @team_approval.update_attributes(params[:team_approval])
        format.html { redirect_to(@team_approval, :notice => 'Team approval was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @team_approval.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /team_approvals/1
  # DELETE /team_approvals/1.xml
  def destroy
    @team_approval = TeamApproval.find(params[:id])
    @team_approval.destroy

    respond_to do |format|
      format.html { redirect_to(team_approvals_url) }
      format.xml  { head :ok }
    end
  end

  def approve
    @team_approval = TeamApproval.find(params[:id])
    if cannot? :approve, TeamApproval then
	redirect_to "/hax.html"
    end
    @team_approval.update_attribute(:status, "approved")
    @contender = Contender.find(@team_approval.from_contender)
    @contender.update_attribute(:team_id, @team_approval.team.id)

    respond_to do |format|
	format.html { redirect_to(@team_approval.team, :notice => "Approved Request") }
    end
  end

  def reject
    @team_approval = TeamApproval.find(params[:id])
    if cannot? :reject, TeamApproval then
	redirect_to "/hax.html"
    end

    @team_approval.update_attribute(:status, "rejected")

    respond_to do |format|
	format.html { redirect_to(@team_approval.team, :notice => "Rejected Request") }
    end

  end

end
