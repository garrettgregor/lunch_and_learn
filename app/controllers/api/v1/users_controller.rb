module Api
  module V1
    class UsersController < ApplicationController
      before_action :new_user

      def create
        return create_user if @user.save
        ## Refactor: to account for all possible errors and individual messages
        render json: ErrorSerializer.new(@user.errors.full_messages).user_errors, status: 404
      end

      private
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

      def new_user
        @user = User.new(user_params)
      end

      def create_user
        @user.update(user_params)
        render json: UserSerializer.new(@user), status: 201
      end
    end
  end
end
