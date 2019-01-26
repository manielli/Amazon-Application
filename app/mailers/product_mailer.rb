class ProductMailer < ApplicationMailer

    def new_product(product)
        @product = product
        @reviews = product.reviews
        @owner = @product.user

        mail(
            to: @owner.email,
            subject: 'You posted a new product.'
        )

    end
end
