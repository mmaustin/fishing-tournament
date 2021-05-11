class ApplicationController < ActionController::Base
    #protect_from_forgery with: 
    skip_forgery_protection
    #protect_from_forgery with: :null_session
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
