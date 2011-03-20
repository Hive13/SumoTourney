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

end
