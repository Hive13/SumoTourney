class SumoMailer < ActionMailer::Base
  default :from => "admin@hive13.org"

  def update_email(contender, subj, body)
    @contender = contender
    @url = default_url_options[:host]
    @msg = body
    mail(:to => contender.email, :subject => subj)
  end
end
