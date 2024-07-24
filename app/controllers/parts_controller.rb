class PartsController < ApplicationController
  before_action :set_resource, only: %i[new create]
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  def new
    @part = @resource.parts.build
  end

  def create
    @part = @resource.parts.build(part_params)
    if @part.save
      redirect_to @resource, notice: 'Part was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @part.update(part_params)
      redirect_to @part.resource, notice: 'Part was successfully updated.'
    else
      render :edit
    end
  end

  def show
  end

  def destroy
    @part.destroy
    redirect_to @part.resource, notice: 'Part was successfully destroyed.'
  end

  private

  def set_resource
    @resource = Resource.find(params[:resource_id])
  end

  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    params.require(:part).permit(:name)
  end
end
