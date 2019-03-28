require 'rails_helper'

RSpec.describe Api::V2::MoviesController, type: :controller do
  let!(:movie) { create(:movie) }

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response_json[0].keys).to contain_exactly("genre", "id", "title")
      expect(response_json[0]["genre"].keys).to contain_exactly("id", "name", "number_of_movies")
      expect(response_json[0]["id"]).to eq(movie.id)
    end
  end
  describe "GET #show" do
    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: movie.id }, format: :json

      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
      expect(response_json.keys).to contain_exactly("genre", "id", "title")
      expect(response_json["genre"].keys).to contain_exactly("id", "name", "number_of_movies")
      expect(response_json["id"]).to eq(movie.id)
    end
  end
end
