class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    # binding.pry
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      # binding.pry
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      elsif !@song.nil? && @artist.nil?
        redirect_to song_path(@song)
      end
    else
      @song = Song.find(params[:id])
      # binding.pry
      # redirect_to song_path(@song)
      # redirect_to edit_song_path(@song)

    end
  end

  def new
    if Preference.first.allow_create_songs
      @song = Song.new
    else
      redirect_to songs_path
    end
    # @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    # binding.pry
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
