class LikesController < ApplicationController
    before_action :authenticate_user!

    def create
        # product = Product.find(params[:product_id])
        review = Review.find(params[:review_id])
        product = review.product
        like = Like.new(review: review, user: current_user)

        if like.save
            flash[:success] = "Review liked successfully!"
        else
            flash[:danger] = like.errors.full_messages.join(", ")
        end

        redirect_to product_path(product)
        # review_likes_path	POST	/reviews/:review_id/likes(.:format)	likes#create
    end

    def destroy
        like = current_user.likes.find params[:id]
        review = like.review
        product = review.product

        like.destroy

        redirect_to product_path(product.id)
        # like_path	DELETE	/likes/:id(.:format)	likes#destroy
    end

end
