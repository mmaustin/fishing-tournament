class FishController < ApplicationController

    def index
        if params[:angler_id]
            @fish = Angler.find_by_id(params[:angler_id]).fish
            #binding.pry
        else
            @fish = Fish.all
            #binding.pry
        end
    end

    def show
        if params[:angler_id]
            angler = Angler.find_by_id(params[:angler_id])
            @fish = angler.fish.find_by_id(params[:id])
        else
            @fish = Fish.find_by_id(params[:id])
        end
    end

    def new
        if params[:angler_id]
            @angler = Angler.find_by_id(params[:angler_id])
        else
            @fish = Fish.new
        end
    end

    def create
        #binding.pry
        if params[:fish][:type_id] != ""
        #binding.pry
            @fish = Fish.create(weight: params[:fish][:weight], angler_id: params[:fish][:angler_id], type_id: params[:fish][:type_id])
            #@book.add_to_book_total
            redirect_to fish_path(@fish)
        else
            @fish = Fish.create(fish_params)
        #@book.field = params[:book][:field]
        #@book.save
            #@book.add_to_book_total
            redirect_to fish_path(@fish)
        end
    end

    def edit
        @fish = Fish.find_by_id(params[:id])
    end

    def update
        @fish = Fish.find_by_id(params[:id])
        @fish.update(fish_update_params)
        redirect_to fish_path(@fish)
    end

    def destroy
        Fish.find_by_id(params[:id]).destroy
        redirect_to angler_path(current_user.id) #'/'
    end

    private

    def fish_params
        params.require(:fish).permit(:weight, :angler_id, :type_id, types: [:name]) 
    end

    def fish_update_params
        params.require(:fish).permit(:weight)
    end

end
