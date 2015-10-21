require 'rails_helper'

describe RootController, type: :controller do
  describe 'GET index' do
    it 'should respond with 200 OK' do
      expect(response.status).to be 200
    end
  end
end
