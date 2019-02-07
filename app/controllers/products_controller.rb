class ProductsController < ApplicationController
    before_action :find_product, only: [:show, :edit, :destroy, :update]
    before_action :authenticate_user!, except: [:index, :show, :panel]
    before_action :authorize_user!, only: [:edit, :update, :destroy, :panel]

    def new
        @product = Product.new
    end

    def create
        @product = Product.new product_params
        @product.user = current_user

        if @product.save
            ProductMailer.new_product(@product).deliver_later
            redirect_to product_path(@product.id)
        else
            render :new
        end
    end
    
    def index
        if params[:tag]
            @tag = Tag.find_or_initialize_by(name: params[:tag])
            @products = @tag.products.all_with_review_counts.order(created_at: :desc)
        else
            @products = Product.all_with_review_counts.order(created_at: :desc)
        end

        respond_to do |format|
            format.html { render :index }
            format.json { render json: @products }
        end
    end

    def show
        # @product = Product.find params[:id]
        @reviews = @product.reviews.order(created_at: :desc)
        
        @review = Review.new

        @favourite = @product.favourites.find_by(user: current_user)

        @product.update_columns(hit_count: @product.hit_count + 1)
    end

    def destroy
        # product = Product.find params[:id]
        
        @product.destroy

        redirect_to products_path
    end

    def edit
        # @product = Product.find params[:id]
    end

    def update
        # @product = Product.find params[:id]

        # @product.attributes = product_params
        # if @product.save(validate: false)
        if @product.update product_params
            redirect_to product_path(@product.id)
        else
            render :edit
        end
        
        #@product.update_columns(sale_price: @product.price)
    end

    # def panel
    #     @products = Product.all
    #     @products_count = @products.count
    #     @reviews = Review.all
    #     @reviews_count = @reviews.count
    #     @users = User.all
    #     @users_count = @users.count

    # end

    def favourited
        @products = current_user.favourited_products.all_with_review_counts.order(created_at: :desc)
    end

    private
    def product_params
        params.require(:product).permit(:title, :description, :price, :tag_names)
    end

    def find_product
        @product = Product.find params[:id]
    end

    def authorize_user!
        unless can?(:crud, @product)
            flash[:danger] = "Access Denied!"
            redirect_to product_path(@product)
        end
    end
end