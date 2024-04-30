class StaticPagesController < ApplicationController
  def index
    @photos = []
    return unless params[:flickr_id]

    flickr = Flickr.new ENV['flickr_api_key'], ENV['flickr_shared_secret']
    @flickr_data = flickr.people.getPhotos(user_id: params[:flickr_id])
    @photos = @flickr_data.map do |photo_data|
      url_builder(photo_data['server'], photo_data['id'], photo_data['secret'])
    end
  end

  private

  def url_builder(server_id, id, secret)
    "https://live.staticflickr.com/#{server_id}/#{id}_#{secret}.jpg"
  end
end
