class AlbumsController < ApplicationController
  before_action :set_info
  before_filter :authenicate_user!, only: [:create, :new, :update, :edit, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs

  def index
  end

  def show
    redirect_to album_pictures_path(params[:id])
  end

  def new
    @album = Album.new
    add_breadcrumb "New Album"
  end

  def edit
    add_breadcrumb "Edit Album"
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      flash[:success] = "Created Album #{@album.title}."
      redirect_to albums_path
    else
      flash[:error] = "Couldn't save."
      redirect_to albums_path
    end
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
      add_breadcrumb "Ideaboards", ideaboards_path
      add_breadcrumb @ideaboard.title, ideaboard_path(@ideaboard)
      add_breadcrumb "Albums", albums_path
    end

    def ensure_proper_user
      if current_user.username != @ideaboard.user.username
        flash[:error] = "You do not have permission to do that"
        redirect_to albums_path
      end
    end

    def set_info
      @ideaboard = Ideaboard.find(params[:id])
      @albums = @ideaboard.albums.all
      @user = @ideaboard.user
    end

    def album_params
      params.require(:album).permit(:ideaboard_id, :title)
    end
end
