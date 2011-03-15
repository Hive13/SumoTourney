class Sumobot < ActiveRecord::Base
  validates :botname, :presence => true

  has_attached_file :pic, :styles => { :thumb=> "75x75>", :small=>"150x150>" }
  belongs_to :contender
end
