class AdminController < ApplicationController
  before_filter :authenticate_contender!

  def contenders
    if cannot? :manage, :all
	redirect_to "/hax.html"
    else
      @contenders = Contender.all
    end

     respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @contenders }
     end

  end

  def email_contenders
	email = params[:email]
	subj = email["subj"]
        body = email["body"]
	@contenders = Contender.all
	@contenders.each do |user|
		SumoMailer.update_email(user, subj, body).deliver
	end	
        respond_to do |format|
	  format.html { redirect_to(admin_contenders_path, :notice => 'Emails Sent') }
	end
  end

end
