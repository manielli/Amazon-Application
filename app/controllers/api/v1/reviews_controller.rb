class Api::V1::ReviewsController < Api::ApplicationController
    before_action :authenticate_user!

    def index
        reviews = Review.order(created_at: :desc)
        render json: reviews
    end

    def destroy
        review = Review.find params[:id]

        if can? :delete, review
            review.destroy
            render json: { status: 200 }, status: 200
        else
            render json: { status: 403 }, status: 403
        end
    end
end
