class UsersController < ApplicationController
  def index
    if params[:query].present?
      mail = params[:query]
      @users = User.except_users(current_user).search_by_email(mail).paginate(page: params[:page], per_page: 10)
    else
     @users = User.except_users(current_user).paginate(page: params[:page], per_page: 10)
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :email, :avatar)
  end

end
