Rails.application.routes.draw do
  resources :registries do
    resources :participants
  end
  resources :coordinators

  get '/export_participants', to: 'coordinators#export_participants'
  get '/participants', to: 'participants#participants'
  root "coordinators#index"
end
