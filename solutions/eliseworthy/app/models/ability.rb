class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.admin?
      can :manage, :all
    elsif user
      can :read, Product
      can :manage, LineItem
      can :manage, Cart
      can :manage, OrderItem, :user_id => user.id
      can :manage, Order, :user_id => user.id

    else
      can :read, Product
      can :manage, LineItem
      can :manage, Cart
      can :create, User
    end
  end
end
