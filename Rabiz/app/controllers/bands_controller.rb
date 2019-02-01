class BandsController < ApplicationController 

    def index 
        @bands = Band.all
    end

    def show 
        @band = Band.find_by(id: params[:id])
    end
    
    def new 
        :new
    end

    def edit 
        @band = Band.find_by(id: params[:id])

        if @band 
            :edit 
        else 
            render json: "no such band in the database"
        end
    end 

    def create
        band = Band.new(band_params)

        if band.save! 
           redirect_to band_url(band)
        else 
           :new
        end
    end

    def update 
        band = Band.find_by(id: params[:id])
        if band.update!(band_params)
            redirect_to band_url(band)
        else 
           render json: band.errors.full_messages
        end
    end

    def destroy 
    end


private 
 def band_params 
    params.require(:band).permit(:name)
 end
end



#     bands#index
#           POST   /bands(.:format)          bands#create
#  new_band GET    /bands/new(.:format)      bands#new
# edit_band GET    /bands/:id/edit(.:format) bands#edit
#      band GET    /bands/:id(.:format)      bands#show
#           PATCH  /bands/:id(.:format)      bands#update
#           PUT    /bands/:id(.:format)      bands#update
#           DELETE /bands/:id(.:format)      bands#destroy