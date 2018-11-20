class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  before_save { self.email = email.downcase }
  before_destroy :last_admin
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password

  def admin?
    self.role == 'admin'
  end
  def last_admin
    return unless self.admin?
    if User.where(role: 'admin').count ==1
      errors.add(:base, I18n.t('users.last_admin_error'))
      throw :abort
    end
  end
end
