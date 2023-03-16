require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET #index' do
    before(:example) { get users_path } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes the correct placeholder text' do
      get users_path
      expect(response.body).to include('Here is a list of users')
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }

    before do
      get user_path(user)
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'displays the user information' do
      expect(response.body).to include('Here is a specific user')
    end
  end
end
