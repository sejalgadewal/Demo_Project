require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe EnrollmentsController, type: :controller do
  let(:user) { create(:user) }  
  let(:course) { create(:course) }  

  describe 'GET #index' do
    it 'assigns @enrollments and @courses' do
      sign_in user
      enrollment = create(:enrollment, user: user, course: course)
      get :index
      expect(assigns(:enrollments)).to eq([enrollment])
      expect(assigns(:courses)).to eq([course])
      expect(response).to render_template(:index)
    end
  end 

  describe 'GET #new' do
    it 'assigns @course and @enrollment' do
      sign_in user
      get :new, params: { course_id: course.id }
      expect(assigns(:course)).to eq(course)
      expect(assigns(:enrollment)).to be_a_new(Enrollment)
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new enrollment' do
        sign_in user
        expect {
          post :create, params: { course_id: course.id }
        }.to change(Enrollment, :count).by(1)
        expect(response).to redirect_to(assigns(:course))
      end
    end

    context 'with invalid attributes' do
      it 'does not create a new enrollment' do
        sign_in user
        allow_any_instance_of(Enrollment).to receive(:save).and_return(false)
        expect {
          post :create, params: { course_id: course.id }
        }.not_to change(Enrollment, :count)
        expect(response).to redirect_to(course_path(course))
      end
    end
  end

  describe 'GET #show' do
    it 'assigns @enrollment' do
      sign_in user
      enrollment = create(:enrollment, user: user, course: course)
      get :show, params: { id: enrollment.id }
      expect(assigns(:enrollment)).to eq(enrollment)
      expect(response).to render_template(:show)
    end
  end
end

