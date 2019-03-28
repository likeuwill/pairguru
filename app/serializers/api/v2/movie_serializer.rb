module Api
  module V2
    class MovieSerializer < ActiveModel::Serializer
      attributes :id, :title

      belongs_to :genre, serializer: GenreSerializer
    end
  end
end
