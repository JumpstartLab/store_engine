class CategoryAssignmentsController < ApplicationController

  def create
    @category_assignment = CategoryAssignment.new(params[:category_assignment])
    respond_to do |format|
      if @category_assignment.save
        format.html { redirect_to @category_assignment, notice: 'Category assignment was successfully created.' }
        format.json { render json: @category_assignment, status: :created, location: @category_assignment }
      else
        format.html { render action: "new" }
        format.json { render json: @category_assignment.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    @category_assignment = CategoryAssignment.find(params[:id])
    respond_to do |format|
      if @category_assignment.update_attributes(params[:category_assignment])
        format.html { redirect_to @category_assignment, notice: 'Category assignment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category_assignment.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @category_assignment = CategoryAssignment.find(params[:id])
    @category_assignment.destroy
    respond_to do |format|
      format.html { redirect_to category_assignments_url }
      format.json { head :no_content }
    end
  end
end
