require 'rails_helper'

RSpec.describe RegistriesController do
  describe "GET #index" do
    it "assigns all registries to @registries" do
      registry1 = FactoryBot.create(:registry)
      registry2 = FactoryBot.create(:registry)
      get :index
      expect(assigns(:registries)).to eq([registry1, registry2])
    end
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET #show" do
    it "assigns the requested registry to @registry" do
      registry = FactoryBot.create(:registry)
      get :show, params: { id: registry.id }
      expect(assigns(:registry)).to eq(registry)
    end
    it "renders the show template" do
      registry = FactoryBot.create(:registry)
      get :show, params: { id: registry.id }
      expect(response).to render_template("show")
    end
  end

  describe "GET #new" do
    it "assigns a new registry to @registry" do
      get :new
      expect(assigns(:registry)).to be_a_new(Registry)
    end
    it "assigns all coordinators to @coordinators" do
      coordinator1 = FactoryBot.create(:coordinator)
      coordinator2 = FactoryBot.create(:coordinator)
      get :new
      expect(assigns(:coordinators)).to eq([coordinator1, coordinator2])
    end
    it "renders the new template" do
      get :new
      expect(response).to render_template("new")
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new registry" do
        expect {
          post :create, params: { registry: FactoryBot.attributes_for(:registry) }
        }.to change(Registry, :count).by(1)
      end
      it "redirects to the registries index page" do
        post :create, params: { registry: FactoryBot.attributes_for(:registry) }
        expect(response).to redirect_to(registries_path)
      end
      it "sets a success flash notice" do
        post :create, params: { registry: FactoryBot.attributes_for(:registry) }
        expect(flash[:notice]).to eq('Registry created successfully.')
      end
    end
    context "with invalid parameters" do
      it "does not create a new registry" do
        expect {
          post :create, params: { registry: FactoryBot.attributes_for(:registry, name: "") }
        }.not_to change(Registry, :count)
      end
      it "renders the new template" do
        post :create, params: { registry: FactoryBot.attributes_for(:registry, name: "") }
        expect(response).to render_template("new")
      end
    end
  end

  describe "GET #edit" do
    it "assigns the requested registry to @registry" do
      registry = FactoryBot.create(:registry)
      get :edit, params: { id: registry.id }
      expect(assigns(:registry)).to eq(registry)
    end
    it "renders the edit template" do
      registry = FactoryBot.create(:registry)
      get :edit, params: { id: registry.id }
      expect(response).to render_template("edit")
    end
  end

  describe "PATCH #update" do
    let(:registry) { FactoryBot.create(:registry) }
    context "with valid parameters" do
      it "updates the requested registry" do
        patch :update, params: { id: registry.id, registry: { name: "New Name" } }
        registry.reload
        expect(registry.name).to eq("New Name")
      end
      it "redirects to the registries index page" do
        patch :update, params: { id: registry.id, registry: { name: "New Name" } }
        expect(response).to redirect_to(registries_path)
      end
      it "sets a success flash notice" do
        patch :update, params: { id: registry.id, registry: { name: "New Name" } }
        expect(flash[:notice]).to eq('Registry updated successfully.')
      end
    end
    context "with invalid parameters" do
      it "does not update the requested registry" do
        patch :update, params: { id: registry.id, registry: { name: nil } }
        registry.reload
        expect(registry.name).not_to be_nil
      end

      it "renders the edit template" do
        put :update, params: { id: registry.id, registry: { name: nil } }
        expect(response).to render_template(:edit)
      end

      it "sets an error status" do
        put :update, params: { id: registry.id, registry: { name: nil } }
        expect(response.status).to eq(422)
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the registry" do
      registry = FactoryBot.create(:registry)
      expect {
        delete :destroy, params: { id: registry.id }
      }.to change(Registry, :count).by(-1)
    end

    it "redirects to the index page" do
      registry = FactoryBot.create(:registry)
      delete :destroy, params: { id: registry.id }
      expect(response).to redirect_to(registries_path)
    end

    it "sets a success notice" do
      registry = FactoryBot.create(:registry)
      delete :destroy, params: { id: registry.id }
      expect(flash[:notice]).to eq('Registry deleted successfully.')
    end
  end
end