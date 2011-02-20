class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_contender

  def current_user
	return current_contender
  end

protected
  def set_contender
	@contender = Contender.find(session[:id]) if @contender.nil? && session[:id]
  end
end
