require 'spec_helper'

RSpec.describe InstagramService, type: :services do

  before do
    def instagram_service
      @service ||= InstagramService.new
    end
  end

  describe 'media_search' do
    it 'return an empty array with empty params' do
      params = {}
      assert_equal [], instagram_service.media_search(params)
    end

    it 'return an empty array with params missing lat or lng' do
      params = {lat: '10.8400714', distance: 1}
      result = instagram_service.media_search(params)
      assert_equal [], result
    end

    it 'return an array with full search params' do
      params = {lat: '10.8400714', lng: '106.67377839999999' ,distance: 1}
      result = instagram_service.media_search(params)
      expect(result.size).not_to eq(0)
    end
  end
end