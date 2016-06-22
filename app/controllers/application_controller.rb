class ApplicationController < ActionController::Base
  include LoginHelper
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def require_logged_in
      return true if current_user
      redirect_to sessions_path
      return false
    end

    def team_user_create
      @team = Team.create(team_params)
      u_params = (team_params[:users_attributes]["0"])
      @user = @team.users.build(u_params)
      if @user.save
        @user.update(role: 1)
        UserMailer.account_activation(@user).deliver_now
        flash[:info] = "Please check your email to activate your account."
        redirect_to root_path
      end
    end

    def current_team
        @current_team ||= @current_user.team
    end

    def user_not_authorized
        flash[:alert] = "Access denied."
        redirect_to (request.referrer || root_path)
    end
  end
