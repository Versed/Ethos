class IdeaboardsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @ideaboards = Ideaboard.order('created_at desc').all

    if signed_in?
      @ideaboard = current_user.ideaboards.new
      @ideaboard.build_document
    end
  end

  def show
    @ideaboard = Ideaboard.find(params[:id])
    add_breadcrumb "Ideaboards", ideaboards_path
    add_breadcrumb @ideaboard.title
  end

  def new
    @ideaboard = current_user.ideaboards.new
    @ideaboard.build_document
  end

  def create
    @ideaboard = current_user.ideaboards.new(ideaboard_params)

    if @ideaboard.save
      current_user.create_activity(@ideaboard, 'created')
      redirect_to @ideaboard
    else
      render 'new'
    end
  end

  def edit
    @ideaboard = Ideaboard.find(params[:id])
  end

  def update
    @ideaboard = current_user.ideaboards.find(ideaboard_params)
    @document = @ideaboard.document

    @ideaboard.transaction do
      @ideaboard.update_attributes(ideaboard_params)
      @document.update_attributes(ideaboard_params) if @document
      current_user.create_activity(@ideaboard, 'updated')

      unless @ideaboard.valid? || (@ideaboard.valid? && @document && !@document.valid?)
        raise ActiveRecord::Rollback
      end
    end

    rescue ActiveRecord::Rollback
    flash.now[:error] = "Update Failed"
    render 'edit'
  end

  def ideaboard_params
    params.require(:ideaboard).permit(:title, :description, documents_attributes: [:attachment, :remove_attachment])
  end
end
