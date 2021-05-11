class FishController < ApplicationController

    def show
        @fish = Fish.find_by_id(params[:id])
    end

    def new
        if params[:angler_id]
            @angler = Angler.find_by_id(params[:angler_id])
            #@book = @scholar.books.build
        else
            @fish = Fish.new
        end
    end

    def create
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

    private

    def fish_params
        params.require(:fish).permit(:weight, :angler_id, :type_id, type: [:name]) 
    end

end
