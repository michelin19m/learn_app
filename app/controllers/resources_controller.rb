class ResourcesController < ApplicationController
  before_action :set_skill, only: %i[create new]
  before_action :set_resource, only: [:show, :edit, :update, :destroy]

  def new
    @resource = @skill.resources.build
  end

  def create
    @resource = @skill.resources.build(resource_params)
    if @resource.save
      redirect_to @skill, notice: 'Resource was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @resource.update(resource_params)
      redirect_to @resource.skill, notice: 'Resource was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @resource.destroy
    redirect_to @resource.skill, notice: 'Resource was successfully destroyed.'
  end

  private

  def set_skill
    @skill = Skill.find(params[:skill_id])
  end

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def resource_params
    params.require(:resource).permit(:name)
  end
end
