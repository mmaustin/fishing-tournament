class AnglersController < ApplicationController

    def new
        @angler = Angler.new
    end

    def create
        @angler = Angler.create(angler_params)
        redirect_to '/'
    end

    private

    def angler_params
        params.require(:angler).permit(:name, :email, :password, :hometown, :age, :total_weight)
    end

end
