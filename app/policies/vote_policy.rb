class VotePolicy < ApplicationPolicy
  def up_vote?
    user
  end

  def down_vote?
    user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
