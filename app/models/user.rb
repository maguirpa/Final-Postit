class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false
  validates :username, presence: true, uniqueness: true, length: {minimum: 5}
  validates :password, presence: true, on: :create, length: {minimum: 7}

  after_validation :generate_slug

  def generate_slug
    self.slug = self.username.downcase
  end

  def to_param
    self.slug
  end

end