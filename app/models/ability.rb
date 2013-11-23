class Ability
  include CanCan::Ability

  # Available roles
  def self.roles
    ['admin', 'accountant']
  end

  # Admin abilities
  def admin(user)
    can :manage, :all
  end

  # Accountant abilities
  def accountant(user)
    can :manage, :all
    cantnot :manage, Role
    cantnot :manage, User
    can [:show, :update], User, :id => user.id
  end

  # Prepare roles to show in select inputs etc.
  def self.roles_for_collection
    self.roles.map{|role| [I18n.translate(role, :scope => 'cancan.roles'), role]}
  end

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    user.roles.each do |role|
      self.send(role.name, user)
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
