class TypesController < ApplicationController

    def index
        if current_user
            @types = Type.all
        else
            current_user_flash
        end
    end

    def show #if this throws an error, make sure an angler is logged in
        if current_user 
            @type = find_type_params
            if @type
                @fish = @type.fish.build(angler_id: session[:user_id])
            else
                type_not_found
            end
        else
            current_user_flash
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
        if current_user
            @type = find_type_params  #Type.find_by_id(params[:id])
            if @type
                @type
            else
                type_not_found
            end
        else
            current_user_flash
        end
    end

    def update
        @type = find_type_params   #Type.find_by_id(params[:id])
        if @type.update(type_params)
            redirect_to type_path(@type)
        else
            render :edit
        end
    end

    def destroy
        find_type_params.destroy   #Type.find_by_id(params[:id]).destroy
        redirect_to types_path
    end

    private

    def type_params
        params.require(:type).permit(:name)
    end

    def find_type_params
        Type.find_by_id(params[:id])
    end

    def current_user_flash
        flash[:alert] = "You are not the current user!"
        redirect_to anglers_path
    end

    def type_not_found
        flash[:alert] = "Type not found!"
        redirect_to types_path
    end

end
