require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do
  let(:user) { create(:user) }
  let(:course) { create(:course, user: user) }
  let(:lecture) { create(:lecture, course: course) }
  let(:quiz) { create(:quiz, lecture: lecture) } 

  before do
    sign_in user
    allow(controller).to receive(:set_quiz).and_return(course, lecture)
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: quiz.id }
      expect(response).to have_http_status(:success)
    end
  end
end
