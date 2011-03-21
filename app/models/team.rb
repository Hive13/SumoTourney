class Team < ActiveRecord::Base
 has_many :contenders
 has_many :team_approvals
end
