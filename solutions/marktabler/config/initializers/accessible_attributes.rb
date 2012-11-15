# This allows us to bypass the security of the
# mass-assignment authorizer on a case-by-case basis.
# This also makes the assumption that all roles should inherit
# from :default.
#
# Use:
#
#   record.accessible = [:dangerous_field]
#
#   -or-
#
#   record.accessible = :all if admin?
#
# Note that Rails 3.1 gives you something similar out of the box.
# You can do something like:
#
#   attr_accessible :price, :as => :admin
#   ...
#   Product.create(params[:product], :as => :admin)
#
#   -or-
#
#   Product.create(params[:product], :without_protection => true)
class ActiveRecord::Base
  attr_accessor :accessible

  private
  def mass_assignment_authorizer(role = :default)
    if accessible == :all
      ActiveModel::MassAssignmentSecurity::BlackList.new
    else
      unprotect = accessible || []
      super(:default) + super(role) + unprotect
    end
  end
end
