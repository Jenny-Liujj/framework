class User < ApplicationRecord
  extend Enumerize
  enumerize :role, in: [:super_admin, :admin, :user], default: :user, predicate: true

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :login
  def self.find_for_database_authentication warden_conditions
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end

  mount_uploader :avatar, AvatarUploader
  include Croppable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :collections, dependent: :destroy

  validates :email, :username, uniqueness: true

  def find_vote_for votable
    votes.find_by(votable_id: votable.id, votable_type: votable.class.name)
  end
  def find_collection_for collectable
    collections.find_by(collectable_id: collectable.id, collectable_type: collectable.class.name)
  end

  def name
    username.blank? ? email : username
  end
end
