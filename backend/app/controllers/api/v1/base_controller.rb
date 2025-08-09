module Api
  module V1
    class BaseController < ApplicationController
      before_action :set_default_format
      before_action :set_pagination_defaults

      private

      def set_default_format
        request.format = :json
      end

      def set_pagination_defaults
        @page = (params[:page] || 1).to_i
        @per_page = (params[:per_page] || 20).to_i.clamp(1, 100)
      end

      def render_error(message, status = :unprocessable_entity)
        render json: { error: message }, status: status
      end

      def render_not_found
        render json: { error: 'Resource not found' }, status: :not_found
      end

      def render_unauthorized
        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
