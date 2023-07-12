class CoordinatorsController < ApplicationController
  def index
    @coordinators = Coordinator.all
  end

  def show
    @coordinator = Coordinator.find(params[:id])
  end

  def new
    @coordinator = Coordinator.new
  end

  def create
    @coordinator = Coordinator.new(coordinator_params)
    respond_to do |format|
      if @coordinator.save
        format.html { redirect_to coordinators_path, notice: 'Coordinator created successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @coordinator = Coordinator.find(params[:id])
  end

  def update
    @coordinator = Coordinator.find(params[:id])
    respond_to do |format|
      if @coordinator.update(coordinator_params)
        format.html { redirect_to coordinators_path, notice: 'Coordinator updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @coordinator = Coordinator.find(params[:id])
    @coordinator.destroy
    respond_to do |format|
      format.html { redirect_to coordinators_path, notice: 'Coordinator deleted successfully.' }
    end
  end

  def export_participants
    require 'csv'
    coordinators = Coordinator.all

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ['Name', 'Gender', 'Date of Birth', 'Coordinator']
      coordinators.each do |coordinator|
        coordinator.participants.each do |participant|
          csv << [participant.name, participant.gender, participant.date_of_birth, coordinator.name]
        end
      end
    end

    send_data csv_data, filename: "participants.csv"
  end

  private

  def coordinator_params
    params.require(:coordinator).permit(:name, :email, :phone_number)
  end
end
