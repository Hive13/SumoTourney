class Ability
  include CanCan::Ability

  def initialize(contender)

    contender ||= Contender.new # Guest?
    if contender.role? "admin"
	can :manage, :all
    else
	can :read, :all
	can :update, Sumobot do |sumobot|
	  sumobot.contender_id == contender.id or (sumobot.contender.team == contender.team and sumobot.contender.team)
	end
	can :update, Hackerspace do |hackerspace|
	  hackerspace.contender_id == contender.id
        end
	can :edit,:destroy, Team do |team|
	  team.contender_id == contender.id
        end
        can :show, TeamApproval do |team_approval|
	  team_approval.from_contender == contender.id or (team_approval.team == contender.team and team_approval.team)
	end
	can :approve,:reject, TeamApproval do |team_approval|
	  team_approval.team == contender.team
	end
	can :index, TeamApproval do |team_approval|
	  contender.team.exists?
	end
    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
