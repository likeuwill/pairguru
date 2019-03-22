class MovieDecorator < Draper::Decorator
  delegate_all

  def pairguru_api_info
    @pairguru_api_info ||= Connector::Movie.new(object.title)
  end

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
    pairguru_api_info.cover
  end

  def plot
    pairguru_api_info.plot
  end

  def rating
    pairguru_api_info.rating
  end
end
