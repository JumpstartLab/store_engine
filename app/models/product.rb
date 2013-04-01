class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :status, :category_ids, :image
  has_and_belongs_to_many :categories
  has_attached_file :image, styles: { medium: "400x400!", thumb: "200x200!" }

  validates :title, presence: :true,
                    uniqueness: { case_sensitive: false }
  validates :description, presence: :true
  validates :status, presence: :true,
                     inclusion: { in: %w(active retired) }
  validates :price, presence: :true,
                    format: { with: /^\d+??(?:\.\d{0,2})?$/ },
                    numericality: { greater_than: 0 }

  def retire
    self.update_attributes(status: 'retired')
  end

  def activate
    self.update_attributes(status: 'active')
  end
end
