class User < ApplicationRecord
  has_many :lessons, dependent: :destroy
  has_many :categories, through: :lessons
  has_many :active_relationships, class_name: "Relationship",
    foreign_key: "follower_id",
    dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
    foreign_key: "followed_id",
    dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true
  mount_uploader :avatar, AvatarUploader

  def follow(user)
    active_relationships.create(followed: user)
  end

  def unfollow(user)
    active_relationships.find_by(followed: user).destroy
  end

  def following?(user)
    following.include?(user)
  end
end