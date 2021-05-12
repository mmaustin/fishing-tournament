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

    def edit
        @type = Type.find_by_id(params[:id])
    end

    def update
        @type = Type.find_by_id(params[:id])
        @type.update(type_params)
        redirect_to type_path(@type)
    end

    def destroy
        Type.find_by_id(params[:id]).destroy
        redirect_to types_path
    end

    private

    def type_params
        params.require(:type).permit(:name)
    end

end
