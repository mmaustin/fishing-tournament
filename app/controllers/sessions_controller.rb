class SessionsController < ApplicationController
    #skip_before_action :verify_authenticity_token
    helper_method :current_user, :logged_in?

    def new
    end

    def create
        #binding.pry
        angler = Angler.find_by(name: params[:name])
        if angler && angler.authenticate(params[:password])
            session[:user_id] = angler.id
            #binding.pry
            redirect_to angler_path(angler)
        else
            redirect_to '/'
        end

    end

    def destroy
        session.delete :user_id
        redirect_to '/'
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