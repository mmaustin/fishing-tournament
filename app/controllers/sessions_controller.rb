class SessionsController < ApplicationController
    #skip_before_action :verify_authenticity_token

    def new
    end

    def create
#=begin
        angler = Angler.find_by(name: params[:name])
        if angler && angler.authenticate(params[:password])
            session[:user_id] = angler.id
            binding.pry
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

end