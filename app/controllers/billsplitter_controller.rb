class BillsplitterController < ApplicationController
    
    def bill_splitter
    end

    def process_bill_splitter
        @amount = params[:amount].to_f
        @tax = params[:tax].to_f
        @tip = params[:tip].to_f
        @num_people = params[:num_people].to_f

        @result = ( @amount + ( (@amount + (@amount * @tax/100)) * @tip/100)  )/@num_people
        render :bill_splitter
    end


end
