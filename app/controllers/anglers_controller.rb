class AnglersController < ApplicationController
    helper_method :current_user, :logged_in?

    def index
        @anglers = Angler.all
    end

    def show
        @angler = Angler.find_by_id(params[:id])
    end

    def new
        @angler = Angler.new
    end

    def create
        @angler = Angler.create(angler_params)
        session[:user_id] = @angler.id
        redirect_to '/'
    end

    private

    def angler_params
        params.require(:angler).permit(:name, :email, :password, :hometown, :age, :total_weight)
    end
=begin
    def current_user
        @current_user ||= Angler.find_by_id(session[:user_id])
    end

    def logged_in?
        !!current_user
    end
=end
end
