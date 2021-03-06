class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    helper_method :current_user, :logged_in?


    def home
    end

    def current_user
        @current_user ||= Angler.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end


end
