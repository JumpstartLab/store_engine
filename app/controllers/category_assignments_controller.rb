class CategoryAssignmentsController < ApplicationController
  # GET /category_assignments
  # GET /category_assignments.json
  def index
    @category_assignments = CategoryAssignment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @category_assignments }
    end
  end

  # GET /category_assignments/1
  # GET /category_assignments/1.json
  def show
    @category_assignment = CategoryAssignment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category_assignment }
    end
  end

  # GET /category_assignments/new
  # GET /category_assignments/new.json
  def new
    @category_assignment = CategoryAssignment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category_assignment }
    end
  end

  # GET /category_assignments/1/edit
  def edit
    @category_assignment = CategoryAssignment.find(params[:id])
  end

  # POST /category_assignments
  # POST /category_assignments.json
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

  # PUT /category_assignments/1
  # PUT /category_assignments/1.json
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

  # DELETE /category_assignments/1
  # DELETE /category_assignments/1.json
  def destroy
    @category_assignment = CategoryAssignment.find(params[:id])
    @category_assignment.destroy

    respond_to do |format|
      format.html { redirect_to category_assignments_url }
      format.json { head :no_content }
    end
  end
end
