# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  before_validation { email.downcase! }
  has_many :blogs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :comment_blogs, through: :comments, source: :blog
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  has_many :passive_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+.-]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
  format: { with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def follow!(other_user)
    active_relationships.create!(followed_id: other_user.id)
  end

  def following?(other_user)
    active_relationships.find_by(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end
end
