class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      show_success_msg
      redirect_to user
    else
      show_fail_msg
      redirect_to root_url
    end
  end

  private

  def show_fail_msg
    flash[:danger] = t ".invalid_link"
  end

  def show_success_msg
    flash[:success] = t ".success"
  end
end
