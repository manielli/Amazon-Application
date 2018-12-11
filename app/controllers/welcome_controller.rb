class WelcomeController < ApplicationController

    def index
        render :index
    end

    def about
    end

    def contact
    end

    def process_contact

        @full_name = params[:full_name]
        @message =  params[:message]
        @email = params[:email]

        render :thank_you
    end

end