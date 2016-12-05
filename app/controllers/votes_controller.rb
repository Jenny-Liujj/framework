class VotesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vote

  def up_vote
    if @vote.value < 1 and not @vote.is_abused?
      @vote.update_attribute :value, @vote.value+1
      @vote.votable.update_attribute :vote_count, @vote.votable.vote_count+1
    end
  end

  def down_vote
    if @vote.value > -1 and not @vote.is_abused?
      @vote.update_attribute :value, @vote.value-1
      @vote.votable.update_attribute :vote_count, @vote.votable.vote_count-1
    end
  end

  private

  def set_vote
    args = { votable_type: params[:votable_type], votable_id: params[:votable_id] }
    @vote = current_user.votes.find_or_create_by args
  end
end
