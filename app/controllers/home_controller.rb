class HomeController < ApplicationController
  def index
	if contender_signed_in?
		@contender = Contender.find(current_contender.id)
	end
  end

end
