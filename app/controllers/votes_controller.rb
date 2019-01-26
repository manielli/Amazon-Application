class VotesController < ApplicationController
    before_action :authenticate_user!

    def create
        review = Review.find(params[:review_id])
        product = review.product
        vote = Vote.new(review: review, user: current_user)
        vote.status = params[:status]        

        if vote.save
            flash[:success] = "Thanks for voting"
        else
            flash[:danger] = vote.errors.full_messages(", ")
        end

        redirect_to product_path(product.id)
        # review_votes_path	POST	/reviews/:review_id/votes(.:format)	votes#create
    end

    def destroy
        vote = current_user.votes.find(params[:id])
        review = vote.review
        product = review.product

        vote.destroy
        flash[:success] = "Successfully unvoted"

        redirect_to product_path(product.id)
        # vote_path DELETE	/votes/:id(.:format)	votes#destroy

    end

    def update
        vote = current_user.votes.find(params[:id])
        vote.status = !vote.status
        review = vote.review
        product = review.product

        vote.save
        redirect_to product_path(product.id)
        
        # vote_path	PATCH	/votes/:id(.:format)	votes#update
    end
end
