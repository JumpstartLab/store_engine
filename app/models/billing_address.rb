class BillingAddress < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :company, :line_1, :line_2,
                  :city, :state, :zipcode,:phone
  has_one :user
  has_one :order
  before_validation(:on => :create) do
    self.phone = phone.gsub(/\D/, '').to_i if attribute_present?("phone")
  end

  validates :first_name, :last_name, :line_1, :city, :state, :zipcode,
            :phone, :presence => true
  validates :zipcode, :length => { :is => 5 }
  validates :zipcode, :numericality => true
  validates :state, :length => { :is => 2 }
  validates :phone, :length => { :is => 10 }
  validates :phone, :numericality => true
end
