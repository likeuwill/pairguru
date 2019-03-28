module Api
  module V2
    class GenreSerializer < ActiveModel::Serializer
      attributes :id, :name, :number_of_movies

      # we can use counter_cache to hold count in db
      def number_of_movies
        object.movies.count
      end
    end
  end
end
