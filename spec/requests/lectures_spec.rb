
require 'rails_helper'

RSpec.describe LecturesController, type: :controller do
  let(:user) { create(:user) } 
  let(:course) { create(:course) } 

  before do
    sign_in user
    allow(controller).to receive(:set_course).and_return(course)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { course_id: course.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new, params: { course_id: course.id }
      expect(response).to have_http_status(:success)
    end

  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new lecture' do
        lecture_params = attributes_for(:lecture) 
        expect do
          post :create, params: { course_id: course.id, lecture: lecture_params }
        end.to change(Lecture, :count).by(1)
      end

    end

    context 'with invalid params' do
      it 'does not create a new lecture' do
        expect do
          post :create, params: { course_id: course.id, lecture: { video: nil } }
        end.not_to change(Lecture, :count)
      end
  
    end
  end

end
