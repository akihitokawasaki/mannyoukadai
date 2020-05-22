class User < ApplicationRecord
  before_destroy :do_not_destroy_last_admin
  private
  def do_not_destroy_last_admin
    throw(:abort) if User.where(admin: true).count <= 1 && self.admin?
  end
  has_many :tasks
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
                                    before_validation { email.downcase! }
                                    has_secure_password
                                    validates :password, presence: true, length: { minimum: 6 }


end
