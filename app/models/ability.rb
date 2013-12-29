# encoding: utf-8
class Ability
  include CanCan::Ability

  # Available roles
  def self.roles
    ['admin', 'base']
  end

  # Admin abilities
  def admin(user)
    can :manage, :all
  end

  # Base abilities
  def base(user)
    can :manage, :all
    cannot :manage, Role
    cannot :manage, User
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

  end
end
