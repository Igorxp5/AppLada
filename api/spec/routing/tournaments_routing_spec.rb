require "rails_helper"

RSpec.describe TournamentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tournaments").to route_to("tournaments#index")
    end

    it "routes to #show" do
      expect(:get => "/tournaments/1").to route_to("tournaments#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tournaments").to route_to("tournaments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tournaments/1").to route_to("tournaments#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tournaments/1").to route_to("tournaments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tournaments/1").to route_to("tournaments#destroy", :id => "1")
    end
  end
end
