Rails.application.routes.draw do
  scope module: "web" do
    root "tasks#index"

    resources :tasks, only: [:index]

    resource "users", only: [:new, :create], path_names: { new: "sign_up" } do
      resource :session, only: [], path: "" do
        get    :new,     path: "sign_in", as: :new
        post   :create,  path: "sign_in"
        delete :destroy, path: "sign_out", as: :destroy
      end
    end

    namespace :account do
      resources :tasks do
        resources :states, only: :update
      end
    end
  end
end
