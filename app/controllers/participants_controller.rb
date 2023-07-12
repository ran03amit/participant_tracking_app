class ParticipantsController < ApplicationController
  def index
    @registry = Registry.find(params[:registry_id])
    @enrollments = @registry.enrollments.group_by(&:coordinator)
  end

  def participants
    @participants = Participant.all
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def new
    @registry = Registry.find(params[:registry_id])
    @participant = Participant.new
  end

  def create
    @registry = Registry.find(params[:registry_id])
    @participant = Participant.find_or_create_by(participant_params)
    @enrollment = Enrollment.new(
      registry_id: @registry.id,
      coordinator_id: params[:participant][:coordinator_id],
      participant_id: @participant.id,
      date_of_enrollment: params[:participant][:date_of_enrollment],
      method_of_contact: params[:participant][:method_of_contact],
      remarks: params[:participant][:remarks]
    )

    respond_to do |format|
      if @enrollment.save
        format.html { redirect_to registry_participants_path(@registry), notice: 'Participant enrolled successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to participants_path(@registry), notice: 'Participant deleted successfully.'
  end

  private

  def participant_params
    params.require(:participant).permit(:name, :gender, :date_of_birth)
  end
end