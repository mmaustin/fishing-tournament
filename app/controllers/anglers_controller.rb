class AnglersController < ApplicationController

    def index
        @anglers = Angler.order(catch_weight: :desc)
    end

    def show
        #@angler = Angler.find_by_id(params[:id])
        find_angler   #@angler = Angler.find_by_id(params[:id])
        if @angler
            @fish = @angler.fish.weighs_more_than(10)
        else
            angler_not_found
        end
    end

    def new
        @angler = Angler.new
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
        if !find_angler
            angler_not_found
        else
            find_angler
        end
        #@angler = Angler.find_by_id(params[:id])
    end

    def update
        find_angler
        #@angler = Angler.find_by_id(params[:id])
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
        flash[:alert] = "Angler not found!"
        redirect_to anglers_path
    end

end
