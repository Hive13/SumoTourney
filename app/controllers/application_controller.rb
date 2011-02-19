class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_contender

protected
  def set_contender
	@contender = Contender.find(session[:id]) if @contender.nil? && session[:id]
  end

  def login_required
	return true if @contender
	access_denied
	return false
  end

  def access_denied
	session[:return_to] = request.request_uri
	flash[:error] = "You must first login to view this page"
	redirect_to :controller => 'contender', :action => 'login'
  end

end
