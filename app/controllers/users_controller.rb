class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  # def new
  # end
  #
  # def create
  #   if params[:image].nil?
  #     params[:image] = nil #return plain user shadow
  #   end
  #   @user = User.new(user_params)
  #   #create a session_controller.new
  # end
  #
  # private
  #
  # def user_params
  #   params.permit(:first_name, :last_name, :image, :email)
  # end

end
