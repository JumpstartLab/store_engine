class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :image,
                  :remote_image_url, :remove_image,
                  :retired, :category_ids


  has_many :orders
  
  has_many :product_categories
  has_many :categories, :through => :product_categories

  mount_uploader :image, ImageUploader

  def self.active
    where(:retired => false)
  end

  def self.retired
    where(:retired => true)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ["name LIKE ? and retired=?", "#{search}", false])
    else
      find(:all, :conditions => ["retired=?", false])
    end
  end

  def retire
    self.retired = true
    save
  end

  def activate
    self.retired = false
    save
  end

end