class TypesController < ApplicationController

    def index
        @types = Type.all
    end

    def show
        @type = Type.find_by_id(params[:id])
        if @type
            @fish = @type.fish.build(angler_id: session[:user_id])
        else
            redirect_to types_path
        end
    end

    def new
        @type = Type.new
    end

    def create
        @type = Type.new(type_params)
        if @type.save
            redirect_to types_path
        else
            render :new
        end
    end

    def edit
        @type = Type.find_by_id(params[:id])
    end

    def update
        @type = Type.find_by_id(params[:id])
        if @type.update(type_params)
            redirect_to type_path(@type)
        else
            render :edit
        end
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
