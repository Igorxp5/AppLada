require 'rails_helper'

RSpec.describe "UserFollowers", type: :request do
  describe "GET /user_followers" do
    it "works! (now write some real specs)" do
      get user_followers_path
      expect(response).to have_http_status(200)
    end
  end
end
