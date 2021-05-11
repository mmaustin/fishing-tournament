class TypesController < ApplicationController

    def index
        @types = Type.all
    end

    def show
        @type = Type.find_by_id(params[:id])
        @fish = @type.fish.build(angler_id: session[:user_id])
    end

    def new
        @type = Type.new
    end

    def create
        @type = Type.create(type_params)
        redirect_to types_path
    end

    private

    def type_params
        params.require(:type).permit(:name)
    end

end
