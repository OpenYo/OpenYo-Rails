class User < ActiveRecord::Base
  has_many :yos, dependent: :destroy
  has_many :friends, dependent: :destroy
  has_many :api_keys, dependent: :destroy
  before_save { self.name = name.downcase }
  validates :name,
    presence: true,
    length: { maximum: 31 },
    format: { with: /[a-z0-9]+/ },
    uniqueness: { case_sensitive: false }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

  def to_param  # overridden
    name
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def become_friends_with(friend)
    # is there more better method?
    self.friends.find_or_create_by(user_id: self.id) do |f|
      f.with_id = friend.id
    end
    friend.friends.find_or_create_by(user_id: friend.id) do |f|
      f.with_id = self.id
    end
  end
end
