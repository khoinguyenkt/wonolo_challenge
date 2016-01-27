class PostsController < ApplicationController

  def index
    @posts = instagram_service.media_search(params)
  end

  private
  def instagram_service
    @instagram_service ||= InstagramService.new
  end

end
