class SessionsController < ApplicationController

    def new
    end

    def create
        angler = Angler.find_by(name: params[:name])
        if angler && angler.authenticate([params[:password]])
            session[:user_id] = angler.id 
        else
            render :new
        end
    end

    def destroy
        session.delete :user_id
    end

end