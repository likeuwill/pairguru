module Api
  module V2
    class MoviesController < ApiController
      before_action :set_movie, only: [:show]

      def index
        @movies = Movie.includes(:genre).all.decorate

        render json: @movies, each_serializer: ::Api::V2::MovieSerializer
      end

      def show
        render json: @movie, include: "genre", serializer: ::Api::V2::MovieSerializer
      end

      private

      def set_movie
        @movie = Movie.find(params[:id]).decorate
      end
    end
  end
end
