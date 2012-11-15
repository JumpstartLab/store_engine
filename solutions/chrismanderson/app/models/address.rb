class Address < ActiveRecord::Base
  attr_accessible :city, :state, :street_1, :street_2,
                  :user_id, :zip_code, :user
  validates_presence_of :city, :street_1
  validates_length_of :state, :is => 2
  validates_length_of :zip_code, :is => 5
  validates_format_of :zip_code, :with => /^[-0-9]+$/

  belongs_to :user
end
