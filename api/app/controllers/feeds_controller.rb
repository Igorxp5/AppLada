class FeedsController < ApplicationController
    before_action :authenticate_user!
    before_action :validate_limit, only: [:index, :user_feed]

    def index
        following = current_user.following
        following_logins = following.collect do |user|
            user.user_login
        end
        @feeds = Feed.where(user_login: following_logins)
                    .offset(params[:offset]).limit(params[:limit])
                    .order(created_at: :desc)        
        render json: format_response(payload: @feeds), status: :ok
    end

    def user_feed
        @feeds = Feed.where(user_login: params[:user_login])
                    .offset(params[:offset]).limit(params[:limit])
                    .order(created_at: :desc)        
        render json: format_response(payload: @feeds), status: :ok
    end
end