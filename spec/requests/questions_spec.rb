require 'rails_helper'

RSpec.describe Api::V1::QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:quiz) { create(:quiz) }
  let(:question) { create(:question, quiz: quiz) } 
  before do
    sign_in user
    allow(controller).to receive(:set_quiz).and_return(quiz)
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index, params: { quiz_id: quiz.id }
      expect(response).to have_http_status(:success)
    end
  end

end
