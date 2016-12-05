class Comment < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:normal, :accepted], default: :normal, predicate: true

  belongs_to :user
  belongs_to :post
  has_many :votes, as: :votable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  after_create :update_comment_counter

  def update_comment_counter
    self.post.increment! :comment_count
  end
end
