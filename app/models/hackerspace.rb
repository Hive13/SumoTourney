class Hackerspace < ActiveRecord::Base
 has_attached_file :pic, :styles => { :thumb=>"75x75>", :small => "150x150>" }

 has_many :contenders

 def members
   return Contender.find(:all, :conditions => {:hackerspace_id => self.id})
 end
end
