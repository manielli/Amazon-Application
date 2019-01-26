class ReviewMailer < ApplicationMailer

    def new_review(review)
        @review = review
        @reviewer = review.user.full_name
        @product = review.product
        @owner = @product.user

        mail(
            to: @owner.email,
            subject: `You've received a new review on your product.`
        )

    end
end
