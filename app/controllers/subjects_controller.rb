class SubjectsController < ApplicationController
   
  
  def index
    @subjects = Subject.all 
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    #  id = params[:id] # retrieve movie ID from URI route
    @subject = set_subject  #Subject.find(id)
  end

  # GET /movies/new
  def new
    @subject = Subject.new
  end

  # GET /movies/1/edit
  def edit
    @subject = set_subject
  end

  def create
    @subject = Subject.create!(subject_params)
    flash[:notice] = "#{@subject.title} was successfully created."
    redirect_to subjects_path
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    @subject = set_subject
    @subject.update_attributes!(subject_params)
    flash[:notice] = "#{@subject.title} was successfully updated."
    redirect_to subject_path(@subject)
  end

  # DELETE /movies/1
  def destroy
    @subject = set_subject
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.title}' deleted."
    redirect_to subjects_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:subjectcode, :title, :description, :create_date)
    end
end