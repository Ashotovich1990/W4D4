class AlbumsController < ApplicationController
    
    def new 
      :new
    end

    def show 
      @album = Album.find_by(id: params[:id])
    end
    
    def create 
        album = Album.new(album_params)
        if album.save! 
            redirect_to album_url(album)
        else 
            render json: album.errors.full_messages
        end

    end

    def edit 
        @album =Album.find_by(id: params[:id])
        
        if @album 
            :edit 
        else 
            render json: "No such album in the database"
        end
    end

    def update 
        album = Album.find_by(id: params[:id])
        if album.update!(album_params)
            redirect_to album_url(album)
        else 
           render json: album.errors.full_messages
        end
    end

    def destroy 
      album = Album.find_by(id: params[:id])
      
      if album.destroy!
        redirect_to band_url(album.band)
      else
        render json: album.errors.full_messages
      end
    end

    private 
    def album_params 
        params.require(:album).permit(:title,:version, :year, :band_id)
    end
end