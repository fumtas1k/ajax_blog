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
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+.-]+@[a-z\d-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :name, presence: true, length: {maximum: 20}
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true,
  format: { with: VALID_EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

end
