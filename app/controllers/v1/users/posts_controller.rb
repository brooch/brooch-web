module V1
  module Users
    class PostsController < ApplicationController
      def index
        render json: current_user.posts.offset(
          params[:offset] || 0
        ).limit(
          params[:limit]  || 10
        ).to_json
      end

      def create
        @post_with_metadata = current_user.build_post_with_metadata(
          text:   params[:text],
          tags:   params[:tags],
          author: params[:author],
        )

        if @post_with_metadata.save
          render json: @post_with_metadata.to_json
        else
          render json: @post_with_metadata.errors.to_json, status: 400
        end
      end
    end
  end
end
