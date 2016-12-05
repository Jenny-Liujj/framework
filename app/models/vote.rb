class Vote < ApplicationRecord
  belongs_to :user

  def up?
    self.value == 1
  end

  def down?
    self.value == -1
  end

  def new?
    @new ||= self.created_at == self.updated_at
  end

  def votable
    @votable ||= self.votable_type.classify.constantize.find(self.votable_id)
  end

  before_commit :check_abuse
  def is_abused?
    self.abuse > 12 # Add two since abuse is added twice initially.
  end
  def check_abuse
    return true if is_abused?
    last_vote_time = self.new? ? self.created_at : self.updated_at
    self.increment! :abuse if Time.now-last_vote_time < 10.second
    self.update_column :value, 0 if is_abused? # User cannot vote this votable again and set value to zero.
  end

  before_destroy :decrease_vote_count
  def decrease_vote_count
    votable.update_attribute :vote_count, votable.vote_count-self.value
  end
end
