Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]
  
  resources :news_articles#, only: [:new, :create, :show, :destroy, :index]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]
  # resources :reviews
  # resources :admins

  resources :reviews do
    resources :likes, shallow: true, only: [:create, :destroy]
    resources :votes, shallow: true, only: [:create, :destroy, :update]

    # get :voted, on: :collection
    get :liked, on: :collection
  end

  resources :products do
    resources :reviews, only: [:create, :destroy]

    resources :favourites, shallow: true, only: [:create, :destroy]

    get :favourited, on: :collection
  end

  
  # get("/products/new", to: "products#new", as: :new_product)
  # # new_product_path, new_question_url
  # post("/products", to: "products#create", as: :products)
  # # products_path, products_url
  # get("/products", to: "products#index")
  # get("/products/:id", to: "products#show", as: :product)
  # # product_path(<id>), product_url(<id>)
  # delete("products/:id", to: "products#destroy")
  # get("/questions/:id/edit", to: "products#edit", as: :edit_product)
  # #edit_product_path(<id>), edit_product_url(<:id>)
  # patch("/products/:id", to: "products#update")

  get("/", to: "products#index", as: :root)

  get("/about_us", to: "welcome#about")

  get("/contact_us", to: "welcome#contact")
  
  post(
    "/contact_us/process",
    to: "welcome#process_contact",
    as: :process_contact
  )

  get("/bill_splitter", to: "billsplitter#bill_splitter")

  post(
    "/bill_splitter/process",
    to: "billsplitter#process_bill_splitter",
    as: :process_bill_splitter
  )

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :products, only: [:show, :index, :create, :update, :destroy]
      resource :session, only: [:create, :destroy]
    end
  end
end