require 'rails_helper'

  RSpec.describe SchedulesController, type: :controller do
    
    context "When user is logged in" do
      before(:each) do
        @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
        @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
        session[:user_id] = @user.id      
        @current_user = @user      
      end

      describe '#index' do  #there would be quite a few tests here!
        let(:schedule1) {instance_double('Schedule', tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25')}
        let(:schedule2) {instance_double('Schedule', tutor: 'tutor2', subject: 'Biology', student: 'student2', timeslot: '2021-5-25')}
        let(:schedule3) {instance_double('Schedule', tutor: 'tutor3', subject: 'Geography', student: 'student3', timeslot: '2021-5-25')}
        let(:schedules) { [schedule1, schedule2, schedule3] }
        it 'Retrieves all of the schedules' do
          allow(Schedule).to receive(:all).and_return([schedule1, schedule2, schedule3])
          get :index
          expect(assigns(:schedules)).to eq(schedules)
        end    
      end
      
      describe '#new' do    
        it 'selects the new template for rendering' do
          get :new
          expect(response).to render_template('new')
        end
      end
      
      describe '#create' do
        let(:params) { {tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25'} }
        let(:schedule) { instance_double('Schedule', params)}
        let(:id1) {'1'}
        it 'Creates a new schedule' do
          expect(Schedule).to receive(:create!).with(params).and_return(schedule)
          post :create, schedule: params
        end
        it 'Sets a flash message' do
          allow(Schedule).to receive(:create!).with(params).and_return(schedule)
          post :create, schedule: params
          expect(flash[:notice]).to match(/^.* was successfully created.$/)  
        end
        it 'Redirects to the schedule page' do
          allow(Schedule).to receive(:create!).with(params).and_return(schedule)
          post :create, schedule: params
          expect(response).to redirect_to(schedules_path)
        end
      end
      
      describe '#show' do
        let(:schedule1) {instance_double('Schedule', tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25')}
        let(:id1) {'1'}
        it 'Retrieves the schedule' do
          expect(controller).to receive(:set_schedule).and_return(schedule1)
          get :show, id: id1 
        end
        it 'selects the show template for rendering' do
          allow(controller).to receive(:set_schedule).and_return(schedule1)
          get :show, id: id1 
          expect(response).to render_template('show')  
        end
        it 'makes the schedule available to the template' do
          allow(controller).to receive(:set_schedule).and_return(schedule1)
          get :show, id: id1 
          expect(assigns(:schedule)).to eq(schedule1)
        end
      end
      
      describe '#edit' do
        let(:id1) {'1'}
        let(:schedule){instance_double('Schedule', tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25')}
        it 'Retrieves the schedule' do
          expect(controller).to receive(:set_schedule).and_return(schedule)
          get :edit, id: id1 
        end
        it 'selects the Edit template for rendering' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          get :edit, id: id1 
          expect(response).to render_template('edit') 
        end
        it 'makes the schedule available to the template' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          get :edit, id: id1 
          expect(assigns(:schedule)).to eq(schedule)
        end
      end
      
      describe '#destroy' do
        let(:id1) {'1'}
        let(:schedule){instance_double('Schedule', tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25')}
        it 'Retrieves the schedule' do
          expect(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:destroy)
          delete :destroy, :id => id1
        end    
        it 'Calls the destroy method to delete the schedule' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          expect(schedule).to receive(:destroy)
          delete :destroy, :id => id1
        end
        it 'Sets the flash message' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:destroy)
          delete :destroy, :id => id1
          expect(flash[:notice]).to match(/^Appointment for \'[^']*\' deleted.$/)  
        end
        it 'Redirects to the schedules page' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:destroy)
          delete :destroy, :id => id1
          expect(response).to redirect_to(schedules_path)
        end
      end
      
      describe '#update' do
        let(:params) { {tutor: 'tutor1', subject: 'Economics', student: 'student1', timeslot: '2021-05-25'} }
        let(:schedule) { instance_double('Schedule', params)}
        let(:id1) {'1'}
        let(:updated){ instance_double('Schedule', tutor: 'tutor4', timeslot: '2021-05-26') }
        it 'Retrieves the schedule' do
          expect(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:update_attributes!).with(params)
          put :update, id: id1, schedule: params
        end
        it 'Updates the schedule attributes' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          expect(schedule).to receive(:update_attributes!).with(params).and_return(updated)
          put :update, id: id1, schedule: params
        end
        it 'Sets a flash message' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:update_attributes!).with(params).and_return(updated)
          put :update, id: id1, schedule: params
          expect(flash[:notice]).to match(/^.* was successfully updated.$/)  
        end
        it 'Redirects to the schedules page' do
          allow(controller).to receive(:set_schedule).and_return(schedule)
          allow(schedule).to receive(:update_attributes!).with(params).and_return(updated)
          put :update, id: id1, schedule: params
          expect(response).to redirect_to(schedule_path(schedule))
        end
      end
       
    end
    
  end

  

