# Represents the status of the product
class Status < ActiveRecord::Base
  attr_accessible :name

  has_many :orders

  def name
    read_attribute(:name).downcase
  end

  def pending?
    name == 'pending'
  end

  def shipped?
    name == 'shipped'
  end

  def paid?
    name == 'paid'
  end
  
end
