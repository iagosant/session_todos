class AccountActivationsController < ApplicationController
  def edit
  user = User.find_by(email: params[:email])
  byebug
  if user && !user.activated? && user.authenticated?(:activation, params[:id])
    user.update_attribute(:activated, true)
    user.update_attribute(:activated_at, Time.zone.now)
    # log_in user
    flash[:success] = "Account activated!"
    redirect_to root_url
  else
    flash[:danger] = "Invalid activation link"
    # redirect_to root_url
  end
end
end