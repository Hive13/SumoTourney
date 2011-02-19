class Contender::RegistrationsController < Devise::RegistrationsController
  before_filter :check_permisions, :only => [:new, :create, :cancel]
  skip_before_filter :require_no_authentication

  def checkpermissions
     authorize! :create, resources
  end
end
