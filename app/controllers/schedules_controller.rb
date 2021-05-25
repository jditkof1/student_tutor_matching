class SchedulesController < ApplicationController
  
  def index
    @schedules = Schedule.all 
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    #  id = params[:id] # retrieve movie ID from URI route
    @schedule = set_schedule  #Schedule.find(id)
  end

  # GET /movies/new
  def new
    @schedule = Schedule.new
  end

  # GET /movies/1/edit
  def edit
    @schedule = set_schedule
  end

  def create
    @schedule = Schedule.create!(schedule_params)
    flash[:notice] = "#{@schedule.title} was successfully created."
    redirect_to schedules_path
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    @schedule = set_schedule
    @schedule.update_attributes!(schedule_params)
    flash[:notice] = "#{@schedule.title} was successfully updated."
    redirect_to schedule_path(@schedule)
  end

  # DELETE /movies/1
  def destroy
    @schedule = set_schedule
    @schedule.destroy
    flash[:notice] = "Schedule '#{@schedule.title}' deleted."
    redirect_to schedules_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_schedule
      @schedule = Schedule.find(params[:id])
    end
    

    # Never trust parameters from the scary internet, only allow the white list through.
    def schedule_params
      params.require(:schedule).permit(:schedulecode, :title, :description, :create_date)
    end
  
end
