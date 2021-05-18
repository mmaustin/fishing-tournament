class SessionsController < ApplicationController
    helper_method :current_user, :logged_in?

    def new
        if current_user
            flash[:alert] = "You are already logged in."
            redirect_to angler_path(current_user)
        end
    end

    def create
        angler = Angler.find_by(username: params[:session][:username])
        #binding.pry
        if angler && angler.authenticate(params[:session][:password])
            session[:user_id] = angler.id
            redirect_to angler_path(angler)
        else
            flash[:alert] = "Make sure you filled in the form properly."
            render :new
            #redirect_to '/'
        end
    end

    def omniauth
        angler = Angler.find_or_create_by(uid: request.env['omniauth.auth'][:uid], provider: request.env['omniauth.auth'][:provider]) do |u|
            u.username = request.env['omniauth.auth'][:info][:name]
            u.email = request.env['omniauth.auth'][:info][:email]
            u.password = SecureRandom.hex(15)
            u.catch_weight = 0
        end
        if angler#.valid?
            #binding.pry
            session[:user_id] = angler.id
            redirect_to anglers_path
        elsif angler.valid?
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