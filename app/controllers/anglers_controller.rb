class AnglersController < ApplicationController

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
        redirect_to angler_path(@angler)
    end

    def edit
        @angler = Angler.find_by_id(params[:id])
    end

    def update
        @angler = Angler.find_by_id(params[:id])
        @angler.update(angler_params)
        redirect_to angler_path(@angler)
    end

    def destroy
        Angler.find_by_id(params[:id]).destroy
        redirect_to anglers_path
    end

    private

    def angler_params
        params.require(:angler).permit(:name, :email, :password, :hometown, :age, :total_weight)
    end

end

# <%= link_to 'Delete Profile', delete_profile_path(@angler)%>