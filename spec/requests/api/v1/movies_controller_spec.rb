require 'rails_helper'

RSpec.describe Api::V1::MoviesController, type: :controller do
  let!(:movie) { create(:movie) }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response_json.length).to eq(1)
      expect(response_json[0].keys).to contain_exactly("id", "title")
      expect(response_json[0]["id"]).to eq(movie.id)
    end
  end

  describe "GET #show" do
    include Warden::Test::Helpers

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: movie.id }, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(response_json.keys).to contain_exactly("id", "title")
      expect(response_json["id"]).to eq(movie.id)
    end
  end
end
