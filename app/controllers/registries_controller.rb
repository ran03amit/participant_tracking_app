class RegistriesController < ApplicationController
  def index
    @registries = Registry.all
  end

  def show
    @registry = Registry.find(params[:id])
  end

  def new
    @registry = Registry.new
    @coordinators = Coordinator.all
  end

  def create
    @registry = Registry.new(registry_params)
    respond_to do |format|
      if @registry.save
        format.html { redirect_to registries_path, notice: 'Registry created successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @registry = Registry.find(params[:id])
    @coordinators = Coordinator.all
  end

  def update
    @registry = Registry.find(params[:id])
    respond_to do |format|
      if @registry.update(registry_params)
        format.html { redirect_to registries_path, notice: 'Registry updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @registry = Registry.find(params[:id])
    @registry.destroy
    respond_to do |format|
      format.html { redirect_to registries_path, notice: 'Registry deleted successfully.' }
    end
  end

  private

  def registry_params
    params.require(:registry).permit(:name, :location, :state, coordinator_ids: [])
  end
end
