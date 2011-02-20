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
  has_and_belongs_to_many :roles

  def role?(roles)
	return !!self.roles.find_by_name(role.to_s)
  end

end
