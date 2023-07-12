require 'rails_helper'

RSpec.describe CoordinatorsController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns all coordinators to @coordinators" do
      coordinator1 = FactoryBot.create(:coordinator)
      coordinator2 = FactoryBot.create(:coordinator)
      get :index
      expect(assigns(:coordinators)).to match_array([coordinator1, coordinator2])
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      coordinator = FactoryBot.create(:coordinator)
      get :show, params: { id: coordinator.id }
      expect(response).to render_template(:show)
    end

    it "assigns the requested coordinator to @coordinator" do
      coordinator = FactoryBot.create(:coordinator)
      get :show, params: { id: coordinator.id }
      expect(assigns(:coordinator)).to eq(coordinator)
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new coordinator to @coordinator" do
      get :new
      expect(assigns(:coordinator)).to be_a_new(Coordinator)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new coordinator" do
        expect {
          post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator) }
        }.to change(Coordinator, :count).by(1)
      end

      it "redirects to the index page" do
        post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator) }
        expect(response).to redirect_to(coordinators_path)
      end

      it "sets a success notice" do
        post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator) }
        expect(flash[:notice]).to eq('Coordinator created successfully.')
      end
    end

    context "with invalid parameters" do
      it "does not create a new coordinator" do
        expect {
          post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator, name: nil) }
        }.not_to change(Coordinator, :count)
      end

      it "renders the new template" do
        post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator, name: nil) }
        expect(response).to render_template(:new)
      end

      it "sets an error status" do
        post :create, params: { coordinator: FactoryBot.attributes_for(:coordinator, name: nil) }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      coordinator = FactoryBot.create(:coordinator)
      get :edit, params: { id: coordinator.id }
      expect(response).to render_template(:edit)
    end

    it "assigns the requested coordinator to @coordinator" do
      coordinator = FactoryBot.create(:coordinator)
      get :edit, params: { id: coordinator.id }
      expect(assigns(:coordinator)).to eq(coordinator)
    end
  end

  describe "PUT #update" do
    let(:coordinator) { FactoryBot.create(:coordinator) }

    context "with valid parameters" do
      it "updates the coordinator" do
        put :update, params: { id: coordinator.id, coordinator: { name: "Updated Name" } }
        coordinator.reload
        expect(coordinator.name).to eq("Updated Name")
      end

      it "redirects to the index page" do
        put :update, params: { id: coordinator.id, coordinator: { name: "Updated Name" } }
        expect(response).to redirect_to(coordinators_path)
      end

      it "sets a success notice" do
        put :update, params: { id: coordinator.id, coordinator: { name: "Updated Name" } }
        expect(flash[:notice]).to eq('Coordinator updated successfully.')
      end
    end

    context "with invalid parameters" do
      it "does not update the coordinator" do
        put :update, params: { id: coordinator.id, coordinator: { name: nil } }
        coordinator.reload
        expect(coordinator.name).not_to be_nil
      end

      it "renders the edit template" do
        put :update, params: { id: coordinator.id, coordinator: { name: nil } }
        expect(response).to render_template(:edit)
      end

      it "sets an error status" do
        put :update, params: { id: coordinator.id, coordinator: { name: nil } }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the coordinator" do
      coordinator = FactoryBot.create(:coordinator)
      expect {
        delete :destroy, params: { id: coordinator.id }
      }.to change(Coordinator, :count).by(-1)
    end

    it "redirects to the index page" do
      coordinator = FactoryBot.create(:coordinator)
      delete :destroy, params: { id: coordinator.id }
      expect(response).to redirect_to(coordinators_path)
    end

    it "sets a success notice" do
      coordinator = FactoryBot.create(:coordinator)
      delete :destroy, params: { id: coordinator.id }
      expect(flash[:notice]).to eq('Coordinator deleted successfully.')
    end
  end

 describe "GET #export_participants" do
  it "sends the CSV file" do
    coordinator = FactoryBot.create(:coordinator)
    registry = FactoryBot.create(:registry)
    participant = FactoryBot.create(:participant)
    
    enrollment = FactoryBot.create(:enrollment, coordinator: coordinator, registry: registry, participant: participant)

    get :export_participants
    expect(response.headers["Content-Type"]).to eq("text/csv")
    expect(response.headers["Content-Disposition"]).to match(/^attachment; filename=\"participants.csv\"/)
  end
end

end
