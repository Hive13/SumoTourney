class Contender < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
	:username, :hackerspace, :hackerspace_url

  validates :username, :presence => true

  has_many :sumobots
  has_many :role

  def role?(findroles)
	res = self.role.find(:all, :conditions => {:name => findroles.to_s})
	return true if res.size == 1
	return false
  end

end
