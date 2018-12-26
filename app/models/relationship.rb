class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  has_one :activity, as: :action, dependent: :destroy
  validates :follower_id, presence: true
  validates :followed_id, presence: true

  after_create :generate_activity

  private
    def generate_activity
      create_activity(user: follower)
    end
end