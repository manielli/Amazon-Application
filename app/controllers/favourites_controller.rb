class FavouritesController < ApplicationController
    before_action :authenticate_user!

    def create
        product = Product.find(params[:product_id])
        favourite = Favourite.new(product: product, user: current_user)

        if !can?(:favourite, product)
            flash[:warning] = "You can not favourite your own product."
        elsif favourite.save
            flash[:success] = "Product favourited."
        else
            flash[:danger] = favourite.errors.full_messages.join(", ")
        end

        redirect_to product_path(product.id)
    end

    def destroy

        favourite = current_user.favourites.find(params[:id])

        if can?(:destroy, favourite)
            favourite.destroy
            flash[:success] = "This product is no longer in your favourite list."
        else
            flash[:warning] = "Can't remove this item from your favourites."
        end

        redirect_to product_path(favourite.product.id)
    end
end
