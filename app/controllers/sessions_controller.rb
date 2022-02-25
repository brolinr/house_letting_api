class SessionsController < ApplicationController
    def create
        customer = Customer.find_by(phone: params[:session][:phone].downcase)
        puts customer
      end
end
