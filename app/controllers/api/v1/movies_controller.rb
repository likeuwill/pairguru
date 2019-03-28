module Api
  module V1
    class MoviesController < ApiController
      before_action :set_movie, only: [:show]

      def index
        @movies = Movie.all

        render json: @movies, each_serializer: ::Api::V1::MovieSerializer
      end

      def show
        render json: @movie, serializer: ::Api::V1::MovieSerializer
      end

      private

      def set_movie
        @movie = Movie.find(params[:id])
      end
    end
  end
end
