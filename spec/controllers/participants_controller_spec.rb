require 'rails_helper'

RSpec.describe ParticipantsController, type: :controller do
  describe "GET #index" do
    let(:registry) { FactoryBot.create(:registry) }

    it "assigns the registry and enrollments" do
      enrollment = FactoryBot.create(:enrollment, registry: registry)
      get :index, params: { registry_id: registry.id }
      expect(assigns(:registry)).to eq(registry)
      expect(assigns(:enrollments)).to eq({ enrollment.coordinator => [enrollment] })
    end

    it "renders the index template" do
      get :index, params: { registry_id: registry.id }
      expect(response).to render_template(:index)
    end
  end

  describe "GET #participants" do
    it "assigns all participants" do
      participant1 = FactoryBot.create(:participant)
      participant2 = FactoryBot.create(:participant)
      get :participants
      expect(assigns(:participants)).to eq([participant1, participant2])
    end

    it "renders the participants template" do
      get :participants
      expect(response).to render_template(:participants)
    end
  end

  describe "GET #show" do
    let(:registry) { FactoryBot.create(:registry) }
    let(:participant) { FactoryBot.create(:participant) }

    it "renders the show template" do
      get :show, params: { registry_id: registry.id, id: participant.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    let(:registry) { FactoryBot.create(:registry) }

    it "assigns the registry and participant" do
      get :new, params: { registry_id: registry.id }
      expect(assigns(:registry)).to eq(registry)
      expect(assigns(:participant)).to be_a_new(Participant)
    end

    it "renders the new template" do
      get :new, params: { registry_id: registry.id }
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:registry) { FactoryBot.create(:registry) }
    let(:coordinator) { FactoryBot.create(:coordinator) }

    context "with valid parameters" do
      let(:valid_params) do
        {
          registry_id: registry.id,
          participant: {
            name: "John Doe",
            gender: "Male",
            date_of_birth: Date.new(2000, 1, 1),
            coordinator_id: coordinator.id,
            date_of_enrollment: Date.today,
            method_of_contact: "Email",
            remarks: "Some remarks"
          }
        }
      end

      it "creates a new participant and enrollment" do
        expect {
          post :create, params: valid_params
        }.to change(Participant, :count).by(1)
          .and change(Enrollment, :count).by(1)
      end

      it "redirects to the registry participants index" do
        post :create, params: valid_params
        expect(response).to redirect_to(registry_participants_path(registry))
      end

      it "sets a flash notice" do
        post :create, params: valid_params
        expect(flash[:notice]).to eq('Participant enrolled successfully.')
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          registry_id: registry.id,
          participant: {
            name: nil,
            gender: nil,
            date_of_birth: nil,
            coordinator_id: coordinator.id,
            date_of_enrollment: Date.today,
            method_of_contact: "Email",
            remarks: "Some remarks"
          }
        }
      end

      it "does not create a new participant or enrollment" do
        expect {
          post :create, params: invalid_params
        }.to change(Participant, :count).by(0)
          .and change(Enrollment, :count).by(0)
      end

      it "renders the new template" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:registry) { FactoryBot.create(:registry) }
    let!(:participant) { FactoryBot.create(:participant) }

    it "destroys the participant" do
      expect {
        delete :destroy, params: { registry_id: registry.id, id: participant.id }
      }.to change(Participant, :count).by(-1)
    end

    it "redirects to the participants index" do
      delete :destroy, params: { registry_id: registry.id, id: participant.id }
      expect(response).to redirect_to(participants_path)
    end

    it "sets a flash notice" do
      delete :destroy, params: { registry_id: registry.id, id: participant.id }
      expect(flash[:notice]).to eq('Participant deleted successfully.')
    end
  end
end
