class FishController < ApplicationController

    def index
        if params[:angler_id]
            @fish = find_angler_params.fish#Angler.find_by_id(params[:angler_id]).fish
        else
            @fish = Fish.all
        end
    end

    def show
        if params[:angler_id]
            angler = find_angler_params
            #angler = Angler.find_by_id(params[:angler_id])
            if angler
                @fish = angler.fish.find_by_id(params[:id])
            else
                redirect_to anglers_path
            end
        else
            @fish = Fish.find_by_id(params[:id])
        end
    end

    def new
        if params[:angler_id]
            angler = find_angler_params#Angler.find_by_id(params[:angler_id])
            if angler
                @fish = angler.fish.build
            else
                redirect_to anglers_path
            end
        else
            @fish = Fish.new(angler_id: session[:user_id])
        end
    end

    def create
        if params[:fish][:type_id] != ""
            @fish = Fish.new(weight: params[:fish][:weight], angler_id: params[:fish][:angler_id], type_id: params[:fish][:type_id])
            if @fish.save
                @fish.weight_total
                redirect_to anglers_path
            else
                render :new
            end
        else
            @fish = Fish.new(fish_params)
            if @fish.save
                @fish.weight_total
                redirect_to anglers_path
            else
                render :new
            end
        end
    end

    def edit
        @fish = find_fish_params   #Fish.find_by_id(params[:id])
    end

    def update
        @fish = find_fish_params   #Fish.find_by_id(params[:id])
        if @fish.update(fish_update_params)
            redirect_to fish_path(@fish)
        else
            render :edit
        end
    end

    def destroy
        find_fish_params.destroy   #Fish.find_by_id(params[:id]).destroy
        redirect_to angler_path(current_user.id)
    end

    private

    def fish_params
        params.require(:fish).permit(:weight, :angler_id, :type_id, types: [:name]) 
    end

    def fish_update_params
        params.require(:fish).permit(:weight)
    end

    def find_angler_params
        Angler.find_by_id(params[:angler_id])
    end

    def find_fish_params
        Fish.find_by_id(params[:id])
    end

end
