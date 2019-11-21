require "rails_helper"

RSpec.describe UserFollowersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/user_followers").to route_to("user_followers#index")
    end

    it "routes to #show" do
      expect(:get => "/user_followers/1").to route_to("user_followers#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/user_followers").to route_to("user_followers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/user_followers/1").to route_to("user_followers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/user_followers/1").to route_to("user_followers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_followers/1").to route_to("user_followers#destroy", :id => "1")
    end
  end
end
