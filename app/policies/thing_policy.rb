class ThingPolicy  < ApplicationPolicy
  attr_reader :user, :thing

  def initialize(user, thing)
    @user = user
    @thing = thing if thing.is_a? Thing
  end

  def update?
    true
  end

  def bbb_able?
    true
  end

  def ccc_able?
    if thing.is_a? Thing
      !!thing.bbb
    else
      # ask me later
      false
    end
  end


  def edit?
    true
  end

  def show?
    true
  end

  def index?
    true
  end

  def new?
    true
  end

  def create?
    true
  end

  def destroy?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
