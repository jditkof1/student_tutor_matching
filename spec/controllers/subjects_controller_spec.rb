require 'rails_helper'

# integration tests
# deep (hit the database)
# shallow (stub the database, stubbing the collaborating model)

describe SubjectsController, type: :controller do
  
  describe '#index' do  #there would be quite a few tests here!
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end 
    let(:subject1) {instance_double('Subject', subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    let(:subject2) {instance_double('Subject', subjectcode: '127A5', title: 'Biology', description: 'Plants and animals', create_date: '1971-03-11')}
    let(:subject3) {instance_double('Subject', subjectcode: '190H5', title: 'Geography', description: 'Maps and directions', create_date: '1982-06-25')}
    let(:subjects) { [subject1, subject2, subject3] }
    it 'Retrieves all of the subjects' do
      allow(Subject).to receive(:all).and_return([subject1, subject2, subject3])
      get :index
      expect(assigns(:subjects)).to eq(subjects)
    end
  end
  describe '#new' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end     
    it 'selects the new template for rendering' do
      get :new
      expect(response).to render_template('new')
    end
  end  
  describe '#create' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end 
    let(:params) { {subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25'} }
    let(:subject) { instance_double('Subject', params)}
    let(:id1) {'1'}
    it 'Creates a new subject' do
      expect(Subject).to receive(:create!).with(params).and_return(subject)
      post :create, subject: params
    end
    it 'Sets a flash message' do
      allow(Subject).to receive(:create!).with(params).and_return(subject)
      post :create, subject: params
      expect(flash[:notice]).to match(/^.* was successfully created.$/)  
    end
    it 'Redirects to the subject page' do
      allow(Subject).to receive(:create!).with(params).and_return(subject)
      post :create, subject: params
      expect(response).to redirect_to(subjects_path)
    end
  end
  describe '#show' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:subject1) {instance_double('Subject', subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    let(:id1) {'1'}
    it 'Retrieves the subject' do
      expect(controller).to receive(:set_subject).and_return(subject1)
      get :show, id: id1 
    end
    it 'selects the show template for rendering' do
      allow(controller).to receive(:set_subject).and_return(subject1)
      get :show, id: id1 
      expect(response).to render_template('show')  
    end
    it 'makes the subject available to the template' do
      allow(controller).to receive(:set_subject).and_return(subject1)
      get :show, id: id1 
      expect(assigns(:subject)).to eq(subject1)
    end
  end
  describe '#edit' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:id1) {'1'}
    let(:subject){instance_double('Subject', subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    it 'Retrieves the subject' do
      expect(controller).to receive(:set_subject).and_return(subject)
      get :edit, id: id1 
    end
    it 'selects the Edit template for rendering' do
      allow(controller).to receive(:set_subject).and_return(subject)
      get :edit, id: id1 
      expect(response).to render_template('edit') 
    end
    it 'makes the subject available to the template' do
      allow(controller).to receive(:set_subject).and_return(subject)
      get :edit, id: id1 
      expect(assigns(:subject)).to eq(subject)
    end
  end
  describe '#destroy' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:id1) {'1'}
    let(:subject) {instance_double('Subject', subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25')}
    it 'Retrieves the subject' do
      expect(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:destroy)
      delete :destroy, :id => id1
    end    
    it 'Calls the destroy method to delete the subject' do
      allow(controller).to receive(:set_subject).and_return(subject)
      expect(subject).to receive(:destroy)
      delete :destroy, :id => id1
    end
    it 'Sets the flash message' do
      allow(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:destroy)
      delete :destroy, :id => id1
      expect(flash[:notice]).to match(/^Subject \'[^']*\' deleted.$/)  
    end
    it 'Redirects to the subjects page' do
      allow(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:destroy)
      delete :destroy, :id => id1
      expect(response).to redirect_to(subjects_path)
    end
  end
  describe '#update' do
    before(:each) do
      @user = User.create!(name: 'SUNY Tester', email: 'stester@binghamton.edu')
      @auth = Authorization.create!(provider: "github", uid: "123456", user_id: @user.id)
      session[:user_id] = @user.id      
      @current_user = @user      
    end
    let(:params) { {subjectcode: '12345', title: 'Economics', description: 'Econ', create_date: '1977-05-25'} }
    let(:subject) { instance_double('Subject', params)}
    let(:id1) {'1'}
    let(:updated){ instance_double('Subject', title: 'Zoology', description: 'Animals') }
    it 'Retrieves the subject' do
      expect(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:update_attributes!).with(params)
      put :update, id: id1, subject: params
    end
    it 'Updates the subject attributes' do
      allow(controller).to receive(:set_subject).and_return(subject)
      expect(subject).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, subject: params
    end
    it 'Sets a flash message' do
      allow(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, subject: params
      expect(flash[:notice]).to match(/^.* was successfully updated.$/)  
    end
    it 'Redirects to the subjects page' do
      allow(controller).to receive(:set_subject).and_return(subject)
      allow(subject).to receive(:update_attributes!).with(params).and_return(updated)
      put :update, id: id1, subject: params
      expect(response).to redirect_to(subject_path(subject))
    end
  end
end
