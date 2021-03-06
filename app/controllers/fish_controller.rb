class FishController < ApplicationController
    before_action :require_current_user, only: [:index, :show, :new, :edit]

    def index
        if params[:angler_id]
            if find_angler_params != current_user
                flash[:alert] = "You can't view another angler's haul."
                redirect_to angler_path(current_user)
            else
                @fish = find_angler_params.fish.weighs_more_than(15)
            end
        else
            @fish = Fish.all.weighs_more_than(15)
        end
    end

    def show
        if params[:angler_id]
            angler = find_angler_params
            if angler
                @fish = angler.fish.find_by_id(params[:id])
            else
                redirect_to anglers_path
            end
        else
            show_edit_fish
        end
    end

    def new
        if params[:angler_id]
            angler = find_angler_params
            if angler == current_user
                @fish = angler.fish.build
            else
                flash[:alert] = "You cannot create a new fish, if you aren't logged in."
                redirect_to anglers_path
            end
        else
            @fish = Fish.new(angler_id: session[:user_id])
        end
    end

    def create
        @fish = Fish.new(fish_params)
        if @fish.save
            @fish.weight_total
            redirect_to anglers_path
        else
            #binding.pry
            render :new
        end
    end


    def edit
        show_edit_fish
    end

    def update
        @fish = find_fish_params
        if @fish.update(fish_update_params)
            @fish.update_weight_total
            redirect_to fish_path(@fish)
        else
            render :edit
        end
    end

    def destroy
        find_fish_params.destroy
        redirect_to angler_path(current_user.id)
    end

    private

    def fish_params
        #params.require(:fish).permit(:weight, :angler_id, :type_id, types: [:name])
        params.require(:fish).permit(:weight, :angler_id, :type_id, type_attributes: [:name])
    end

    def fish_update_params
        params.require(:fish).permit(:weight, :previous_weight)
    end

    def find_angler_params
        Angler.find_by_id(params[:angler_id])
    end

    def find_fish_params
        Fish.find_by_id(params[:id])
    end

    def flash_alert
        flash[:alert] = "You are not logged in."
        redirect_to root_path
    end

    def require_current_user
        unless current_user
            flash[:alert] = "You are not the current user!"
            redirect_to anglers_path
        end
    end

    def show_edit_fish
        @fish = find_fish_params
        if !@fish || @fish.angler_id != current_user.id
            flash[:alert] = "That was not your fish."
            redirect_to angler_path(current_user)
        else
            @fish
        end
    end

end
