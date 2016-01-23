class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  before_create :set_expiration
  belongs_to :user

  def expired?
    DateTime.now >= self.expires_at
  end

  private
  def generate_access_token
    begin
      self.access_token = SecureRandom.uuid
    end while self.class.exists?(access_token: access_token)
  end

  def set_expiration
    self.expires_at = 20.years.from_now.utc
  end
end
