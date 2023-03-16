require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET #index' do
    let(:user) { FactoryBot.create(:user) }
    before(:example) { get user_posts_path(user.id) } # get(:index)
    it 'is a success' do
      expect(response).to have_http_status(:ok)
    end
    it "renders 'index' template" do
      expect(response).to render_template('index')
    end
    it 'includes the correct placeholder text' do
      expect(response.body).to include('Here is a list of posts')
    end
  end

  describe 'GET #show' do
    let(:user) { FactoryBot.create(:user) }
    let(:post) { FactoryBot.create(:post_with_user) }

    before do
      get user_post_path(user.id, post.id)
    end

    it 'returns a success response' do
      expect(response).to be_successful
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end

    it 'displays the user information' do
      expect(response.body).to include('Here is a list of posts for a specific user')
    end
  end
end
