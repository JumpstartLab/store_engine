class Product < ActiveRecord::Base
  attr_accessible :title, :description, :price, :image,
                  :remote_image_url, :remove_image,
                  :retired, :category_ids


  validates :title,       :presence => true
  
  validates :description, :presence => true
  
  validates :price,       :presence => true
                          # :numericality => {
                          #   :only_integer => true }
  validates_format_of :remote_image_url, 
  :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

  has_many :orders
  
  has_many :product_categories
  has_many :categories, :through => :product_categories

  has_many :retirements
  has_many :activations

  mount_uploader :image, ImageUploader

  def self.active
    where(:retired => false)
  end

  def self.retired
    where(:retired => true)
  end

  def self.search(search)
    if search
      find(:all, :conditions => ["title LIKE ? and retired=?", "%#{search}%", false])
    else
      find(:all, :conditions => ["retired=?", false])
    end
  end

  def retire
    self.retirements << Retirement.new
    self.retired = true
    save
  end

  def activate
    self.activations << Activation.new
    self.retired = false
    save
  end

  def retired_at
    if self.retired
      self.retirements.last.created_at
    else
      nil
    end
  end

end