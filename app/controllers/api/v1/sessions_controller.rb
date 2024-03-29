module Api
  module V1
    class SessionsController < ApplicationController
      before_action :find_user

      def create
        if @user&.authenticate(params[:password])
          render json: UserSerializer.new(@user), status: :accepted
        else
          render json: ErrorSerializer.new("Invalid Email or Password").credential_errors, status: :unauthorized
        end
      end

      private

      def find_user
        @user = User.find_by(email: params[:email])
      end
    end
  end
end
