require "rails_helper"

RSpec.describe TournamentSubscriptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/tournament_subscriptions").to route_to("tournament_subscriptions#index")
    end

    it "routes to #show" do
      expect(:get => "/tournament_subscriptions/1").to route_to("tournament_subscriptions#show", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/tournament_subscriptions").to route_to("tournament_subscriptions#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/tournament_subscriptions/1").to route_to("tournament_subscriptions#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/tournament_subscriptions/1").to route_to("tournament_subscriptions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/tournament_subscriptions/1").to route_to("tournament_subscriptions#destroy", :id => "1")
    end
  end
end
