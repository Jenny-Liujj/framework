class Post < ApplicationRecord
  extend Enumerize
  enumerize :status, in: [:draft, :online, :offline, :locked], default: :draft, predicate: true

  include PgSearch
  pg_search_scope :search_by_title_or_content,
                  against: [:title, :content],
                  using: { tsearch: { prefix: true, dictionary: 'zhparser' } }

  acts_as_taggable

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one :answer, class_name: 'Comment', dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :collections, as: :collectable, dependent: :destroy

  scope :latest, -> { order('id DESC').limit(50) }
  scope :hottest, -> { where('vote_count >= ? OR collection_count >= ? OR comment_count >= ?', 10, 10, 10).latest }

  def is_on_fire? object
    self.send(:"#{object}_count") > 50
  end
end
