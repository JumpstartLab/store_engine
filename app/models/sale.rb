class Sale < ActiveRecord::Base
  attr_accessible :percent_off, :status, :foreign_key, :group

  validates :status, presence: :true,
                     inclusion: { in: %w(active ended) }
  validates :group, presence: :true,
                    inclusion: { in: %w(product category) }
  validates :foreign_key, presence: :true
  validates :percent_off, presence: true,
                          inclusion: { in: 1..100,
                          message: "percent must be between 1-100" }

  def item
    group.classify.constantize.find(foreign_key)
  end

  def end
    self.update_attributes(status: 'ended')
  end

  def activate
    self.update_attributes(status: 'active')
  end
end
