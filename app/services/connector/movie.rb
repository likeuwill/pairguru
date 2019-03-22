module Connector
  class Movie
    include HTTParty

    attr_reader :movie_title

    default_timeout 1
    API_DOMAIN = "https://pairguru-api.herokuapp.com".freeze
    base_uri "#{API_DOMAIN}/api/v1/movies"
    CACHE_EXPIRATION_IN_MIN = 60

    def initialize(movie_title)
      @movie_title = movie_title
    end

    def cover
      cover_path = api_response.dig("data", "attributes", "poster")
      return nil if cover_path.nil?

      "#{API_DOMAIN}/#{cover_path}"
    end

    def rating
      api_response.dig("data", "attributes", "rating")
    end

    def plot
      api_response.dig("data", "attributes", "plot")
    end

    private

    # API call memoization to make sure we call API once per movie
    def api_response
      @api_response ||= cached do
        handle_errors { api_call.parsed_response }
      end
    end

    def cached
      cache_key = "pairguru_api_response_#{@movie_title}"
      Rails.cache.fetch(cache_key, expires_in: CACHE_EXPIRATION_IN_MIN.minutes) do
        yield
      end
    end

    def api_call
      self.class.get(movie_url)
    end

    def handle_errors
      yield
    rescue StandardError => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.join("\n")
      {}
    end

    def movie_url
      "/#{@movie_title.gsub(' ', '%20')}"
    end
  end
end
