require 'spec_helper'

RSpec.describe PostsController, :type => :controller do
  describe "GET index" do
    it "should allow get list posts" do
      get :index, lat: '10.8400714', lng: '106.67377839999999'
      expect(response).to be_success
    end

    it "should allow get list posts without position" do
      get :index
      expect(response).to be_success
    end
  end
end