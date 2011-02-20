class Sumobot < ActiveRecord::Base
  validates :botname, :presence => true

  belongs_to :contender
end
