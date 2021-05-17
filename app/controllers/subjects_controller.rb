class SubjectsController < ApplicationController
   
  
  def index
    @subjects = Subject.all 
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    id = params[:id] # retrieve movie ID from URI route
    p Subject.all
    @subject = Subject.find(id)
  end

  # GET /movies/new
  def new
    @subject = Subject.new
  end

  # GET /movies/1/edit
  def edit
  end

  def create
    p subject_params
    @subject = Subject.create!(subject_params)
    flash[:notice] = "#{@subject.title} was successfully created."
    redirect_to subjects_path
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subjects was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end
  
    def get_subject
      @subject
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:subjectcode, :title, :description, :create_date)
    end
end