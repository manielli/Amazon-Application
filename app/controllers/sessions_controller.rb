class SessionsController < ApplicationController

    def new
    end

    def create
        user = User.find_by_email params[:email]
        if user&.authenticate params[:password]

            session[:user_id] = user.id
            redirect_to root_path, notice: "#{user.first_name}, you are logged in!"
        else
            flash[:alert] = "Email or password is incorrect"
            render :new
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_path, notice: "Logged out"
    end 
end