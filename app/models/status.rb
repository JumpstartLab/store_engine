class Status < ActiveRecord::Base
  belongs_to :order

  def change
    if name == 'pending'
      self.name = 'paid'
    elsif name == 'paid'
      self.name = 'shipped'
    elsif name == 'shipped'
      self.name = 'returned'
    end
    self.save
  end

  def cancel
    if name == 'pending'
      self.name = 'cancelled'
    end
    self.save
  end
end
