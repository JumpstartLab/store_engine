class CategoryAssignmentsController < ApplicationController

  def create
    @category_assignment = CategoryAssignment.new(params[:category_assignment])
    if @category_assignment.save
      redirect_to @category_assignment
    else
      render action: "new"
    end
  end


  def update
    @category_assignment = CategoryAssignment.find(params[:id])
    if @category_assignment.update_attributes(params[:category_assignment])
      redirect_to @category_assignment
    else
      render action: "edit"
    end
  end


  def destroy
    @category_assignment = CategoryAssignment.find(params[:id])
    @category_assignment.destroy
    redirect_to category_assignments_url
  end
end
