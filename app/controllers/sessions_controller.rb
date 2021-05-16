class SessionsController < ApplicationController
    helper_method :current_user, :logged_in?

    def new
    end

    def create
        angler = Angler.find_by(username: params[:username])
        if angler && angler.authenticate(params[:password])
            session[:user_id] = angler.id
            redirect_to angler_path(angler)
        else
            redirect_to '/'
        end

    end

    def omniauth
        angler = Angler.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
            u.username = request.env['omniauth.auth'][:info][:name]
            u.email = request.env['omniauth.auth'][:info][:email]
            u.password = SecureRandom.hex(15)
            u.catch_weight = 0
        end
        if angler.valid?
            session[:user_id] = angler.id
            redirect_to anglers_path
        else
            redirect_to root_path
        end
    end

    def destroy
        session.delete :user_id
        redirect_to '/'
    end

end