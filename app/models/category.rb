class Category < ActiveRecord::Base
  attr_accessible :name
  has_many :category_assignments
  has_many :products, through: :category_assignments

  before_destroy :ensure_not_assigned


  private

  def ensure_not_assigned
    if products.empty? 
      return true
    else 
      errors.add(:base, 'Assigned to a product')
      return false
    end
  end

end
