class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_filter :authenicate_user!, only: [:create, :new, :update, :edit, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs

  def index
    @albums = Album.all
    respond_with(@albums)
  end

  def show
    respond_with(@album)
  end

  def new
    @album = Album.new
    respond_with(@album)
  end

  def edit
    add_breadcrumb "Editing Album"
  end

  def create
    @album = Album.new(album_params)
    @album.save
    respond_with(@album)
  end

  def update
    if @album.update(album_params)
      redirect_to album_pictures_path(@album), notice: 'Success'
    else
      flash.now[:error] = "Error updating. Please try again."
      render action: "edit"
    end
  end

  def destroy
    @album.destroy
    respond_with(@album)
  end

  private
    def add_breadcrumbs
      add_breadcrumb @ideaboard, ideaboards_path(@ideaboard)
      add_breadcrumb "Albums", albums_path
    end

    def ensure_proper_user
      if current_user.username != @ideaboard.user.username
        flash[:error] = "You do not have permission to do that"
        redirect_to albums_path
      end
    end

    def set_album
      @ideaboard = Ideaboard.find(params[:id])
      @album = @ideaboard.albums.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:ideaboard_id, :title)
    end
end
