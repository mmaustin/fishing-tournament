class AnglersController < ApplicationController

    def index
        @anglers = Angler.order(catch_weight: :desc)
    end

    def show
        @angler = Angler.find_by_id(params[:id])
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
        @angler = Angler.find_by_id(params[:id])
    end

    def update
        @angler = Angler.find_by_id(params[:id])
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

end
