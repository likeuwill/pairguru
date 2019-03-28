module Api
  module V2
    class MoviesController < ApplicationController
      before_action :set_movie, only: [:show]

      def index
        @movies = Movie.includes(:genre).all.decorate
      end

      def show; end

      private

      def set_movie
        @movie = Movie.find(params[:id]).decorate
      end
    end
  end
end
