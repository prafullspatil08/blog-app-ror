# app/models/ability.rb
class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    case user.role
    when "admin"
      can :manage, :all
    when "editor"
      can :create, Post
      can [ :read, :update ], Post, user_id: user.id
    when "viewer"
      can :read, Post
    end

    can :manage, User if user.admin?
    can :read, Audited::Audit if user.admin?
  end
end
