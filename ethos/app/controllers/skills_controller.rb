class SkillsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :new, :update, :edit, :destroy]

  def index
    params[:page] ||= 1
    @skills = Skill.all.group('name').page(params[:page])
  end

  def show
    add_breadcrumb params[:id]
    skills = Skill.where(name: params[:id])
    @ideaboards = skills.map { |skill| skill.skillable_id if skill.skillable_type == 'ideaboard' }
    @profiles = skills.map { |skill| skill.skillable_id if skill.skillable_type == 'profile' }

    if skills.empty?
      redirect_to skills_path
      flash[:error] = "No skills by that name"
    end
  end

  def create
    @skill = Skill.new
    @skill.name = params[:skill][:name]

    if params[:skill][:ideaboard_id]
      @ideaboard = Ideaboard.find_by_id(params[:skill][:profile_id])
      @skill.skillable_type = 'ideaboard'
      @skill.skillable_id = @ideaboard.id
      skill_parent_path = ideaboard_path(@ideaboard)
    else
      @profile = User.find_by_id(params[:skill][:profile_id])
      @skill.skillable_type = 'profile'
      @skill.skillable_id = @profile.id
      skill_parent_path = profile_path(@profile)
    end

    if @skill.save
    else
      flash[:error] = "Error, please try again"
    end
    redirect_to skill_parent_path
  end

  def destroy
    @skill = skill.find_by_name_and_skillable_id(params[:skill_id], params[:id])

    if @skill.destroy
    else
      flash[:error] = "Error. Try again."
    end

    redirect_to(:back)
  end

  private
    def add_breadcrumbs
      add_breadcrumb "Home", ideaboards_path
      add_breadcrumb "Skills", skills_path
    end
end

end
