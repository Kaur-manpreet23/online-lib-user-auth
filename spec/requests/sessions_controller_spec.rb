require 'rails_helper'

RSpec.describe "SessionsControllers", type: :request do
  describe "POST create" do
    it 'should accepts params in json format' do
      post '/login', params: {
        user: {
        email: "abc@xyz.com",
        password: "123"
    }
      },as: :json
      expect(response.media_type).to eq('application/json')
    end

    it 'should not render user and tokens with invalid credentials' do
      post '/login', params: {
        user:{
          email: "a@b.com",
          password: "123"
        }
      }, as: :json
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)

      expect(json_response['status']).to eq(401)
    end

    it 'should render user and tokens with valid credentials' do
      user = FactoryBot.create(:user)
      post '/login', params: {
        user:{
          email: user.email,
          password: user.password
        }
      }, as: :json
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq("created")
      expect(json_response['logged_in']).to be_truthy
    end
  end
end
