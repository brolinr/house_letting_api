class SessionsController < ApplicationController
    def create
        customer = Customer.find_by(phone: params[:session][:phone].downcase)
        if customer
            render json: "Hello D-O Double G"
        else
          render json: 'new'
        end
      end
end
