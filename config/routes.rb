Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]

  resources :reviews

  resources :products do
    resources :reviews, only: [:create, :destroy]
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

  get("/", to: "welcome#index", as: :root)

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

end