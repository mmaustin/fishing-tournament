class AnglersController < ApplicationController

    def index
        @anglers = Angler.order(catch_weight: :desc)
    end

    def show
        find_angler
        if @angler && @angler == current_user
            @fish = @angler.fish.weighs_more_than(10).order(weight: :desc)
        else
            angler_not_found
        end
    end

    def new
        if current_user
            flash[:alert] = "Your account already exists."
            redirect_to angler_path(current_user)
        else
            @angler = Angler.new
        end
    end

    def create
        @angler = Angler.new(angler_params)
        if @angler.save
            session[:user_id] = @angler.id
            redirect_to angler_path(@angler)
        else
            render :new
        end
    end

    def edit
        if current_user
            if !find_angler || find_angler != current_user
                angler_not_found
            else
                find_angler
            end
        else
            flash[:alert] = "You are not the current user."
            redirect_to root_path
        end
    end

    def update
        find_angler
        if @angler.update(angler_params)
            redirect_to angler_path(@angler)
        else
            render :edit
        end
    end

    def destroy
        Angler.find_by_id(params[:id]).destroy
        redirect_to anglers_path
    end

    private

    def angler_params
        params.require(:angler).permit(:username, :email, :password, :hometown, :age, :catch_weight)
    end

    def find_angler
        @angler = Angler.find_by_id(params[:id])
    end

    def angler_not_found
        flash[:alert] = "Angler not found, or you attempted to visit another Anlger's page!"
        redirect_to anglers_path
    end

end
