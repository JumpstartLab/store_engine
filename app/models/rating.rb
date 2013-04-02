class Rating < ActiveRecord::Base
  attr_accessible :body, :stars, :title, :user_id, :product_id

  validates :user_id, presence: true
  validates :product_id, presence: true
  validates :title, presence: true
  validates :body, presence: true
  validates :stars, presence: true, inclusion: 0..5

  def display_name
    User.find(user_id).display_name
  end

  def editable?
    created_at > Time.now.utc - 900
  end
end
