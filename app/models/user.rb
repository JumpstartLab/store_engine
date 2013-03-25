class User < ActiveRecord::Base
  authenticates_with_sorcery!
  attr_accessible :display_name, :email, :full_name
  validates_confirmation_of :password, message: "should match confirmation", if: :password
  has_many :orders

  validates :email, presence: :true, uniqueness: :true
  validates :full_name, presence: :true
  validates :display_name, length: { in: 2..32 }, allow_blank: :true
end
