#encoding: utf-8

module V1
  module Users
    class PostsController < ApplicationController
      before_action :require_owner,      only: [:index, :create, :update, :destroy]
      before_action :require_post_owner, only: [:update, :destroy]

      def index
        render json: current_user.posts.offset(
          params[:offset] || 0
        ).limit(
          params[:limit]  || 10
        ).order(
          'created_at DESC'
        ).to_json(include: [:author, :tags])
      end

      def create
        @post_with_metadata = current_user.build_post_with_metadata(
          text:     params[:text],
          tags:     params[:tags],
          author:   params[:author],
          image_id: params[:image_id],
        )

        if @post_with_metadata.save
          render json: @post_with_metadata.to_json
        else
          render json: @post_with_metadata.errors.to_json, status: 400
        end
      end

      def update
        if @post_with_metadata.update(
          text:     params[:text],
          tags:     params[:tags],
          author:   params[:author],
          image_id: params[:image_id],
        )
          render json: @post_with_metadata.to_json
        else
          render json: @post_with_metadata.errors.to_json, status: 400
        end
      end

      def destroy
        if @post_with_metadata.destroy
          render json: @post_with_metadata.to_json
        else
          render json: @post_with_metadata.errors.to_json, status: 400
        end
      end

      private

      def require_owner
        if !current_user ||
           (current_user.id != params[:user_id].to_i)
          render json: {
            auth_error: ['このリソースへの操作は許可されていません']
          }, status: 403
        end
      end

      def require_post_owner
        @post_with_metadata = PostWithMetadata.find(params[:id])
        if @post_with_metadata.user.id != current_user.id
          render json: {
            auth_error: ['このリソースへの操作は許可されていません']
          }, status: 403
        end
      end
    end
  end
end
