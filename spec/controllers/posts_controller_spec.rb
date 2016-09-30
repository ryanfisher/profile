require 'rails_helper'

describe PostsController, type: :controller do
  describe 'GET #show' do
    it 'returns http success' do
      get :show, path: '2016'
      expect(response).to have_http_status(:success)
    end
  end
end
