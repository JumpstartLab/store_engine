# == Schema Information
#
# Table name: credit_cards
#
#  id                 :integer         not null, primary key
#  credit_card_number :string(255)
#  cvc                :string(255)
#  expiration_date    :string(255)
#  user_id            :integer
#  created_at         :datetime        not null
#  updated_at         :datetime        not null
#

require 'spec_helper'

describe CreditCard do
end
