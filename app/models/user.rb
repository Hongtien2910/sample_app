class User < ApplicationRecord
  before_save :downcase_email

  validates :name, presence: true,
            length: {maximum: Settings.sign_up.max_name}

  validates :email, presence: true,
            length: {maximum: Settings.sign_up.max_email},
            format: {with: Settings.sign_up.email_regex},
            uniqueness: {case_sensitive: false}

  validates :password, presence: true,
            length: {minimum: Settings.sign_up.min_password}

  has_secure_password

  private
  def downcase_email
    email.downcase!
  end
end
