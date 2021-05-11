class SessionsController < ApplicationController
    #skip_before_action :verify_authenticity_token
    helper_method :current_user, :logged_in?

    def new
    end

    def create
#=begin
        angler = Angler.find_by(name: params[:name])
        if angler && angler.authenticate(params[:password])
            session[:user_id] = angler.id
            #binding.pry
            render :new
        else
            render :new
        end
#=end
    end

    def destroy
        session.delete :user_id
        render :new
    end

    private
=begin
    def current_user
        @current_user ||= Angler.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end
=end
end