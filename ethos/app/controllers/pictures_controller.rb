class PicturesController < ApplicationController
  before_action :set_information, only: [:index, :show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :ensure_proper_user, only: [:edit, :new, :create, :update, :destroy]
  before_filter :add_breadcrumbs

  def index
    @pictures = @album.pictures.all
  end

  def show
    @picture = @album.pictures.find(params[:id])
    add_breadcrumb @picture, album_picture_path(@album, @picture)

    respond_with(@picture)
  end

  def new
    @picture = Picture.new
    respond_with(@picture)
  end

  def edit
  end

  def create
    @picture = @album.pictures.new(picture_params)

    if @picture.save
      current_user.create_activity(@picture, 'created')
      redirect_to album_pictures_path(@album, notice: "Picture was created")
    else
      render action: 'new'
      flash[:error] = "Error creating picture"
    end
  end

  def update
    if @picture.update(picture_params)
      current_user.create_activity(@picture, 'updated')
      redirect_to album_pictures_path(@album, notice: "Picture was updated.")
    else
      render action: 'edit'
      flash[:error] = "Error updating picture"
    end
  end

  def destroy
    @picture.destroy
    current_user.create_activity(@picture, 'deleted')
    redirect_to album_pictures_path(@album, notice: "Picture was removed.")
  end

  private
    def add_breadcrumbs
      add_breadcrumb @ideaboard.title, ideaboards_path(@ideaboard)
      add_breadcrumb "Albums", albums_path
      add_breadcrumb @album.title
    end

    def ensure_proper_user
      if current_user.username != @ideaboard.user.username
        flash[:error] = "You do not have permission to do that"
        redirect_to album_pictures_path
      end
    end

    def set_information
      @ideaboard = Ideaboard.find_by_id(params[:id])
      @album = @ideaboard.albums.find(params[:album_id])
      @user = @ideaboard.user
    end

    def picture_params
      params.require(:picture).permit(:album_id, :ideaboard_id, :caption, :description)
    end
end
