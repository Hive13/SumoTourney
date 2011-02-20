class HomeController < ApplicationController
  def index
	if contender_signed_in?
		@contender = Contender.find(current_contender.id)
	end
  end

  def admin
	if cannot? :manage, :all then
	   redirect_to "/hax.html"
        end
  end

end
