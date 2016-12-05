class Collection < ApplicationRecord
  belongs_to :user

  def new?
    @new ||= self.created_at == self.updated_at
  end

  def collectable
    @collectable ||= self.collectable_type.classify.constantize.find(self.collectable_id)
  end

  before_commit :check_abuse
  def is_abused?
    self.abuse > 12 # Add two since abuse is added twice initially.
  end
  def check_abuse
    return true if is_abused?
    last_collect_time = self.new? ? self.created_at : self.updated_at
    self.increment! :abuse if Time.now-last_collect_time < 10.second
    self.update_column :value, 0 if is_abused? # User cannot collect this collectable again and set value to zero.
  end

  before_destroy :decrease_collection_count
  def decrease_collection_count
    collectable.update_attribute :collection_count, collectable.collection_count-self.value
  end
end
