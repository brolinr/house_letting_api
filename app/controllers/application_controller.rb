class ApplicationController < ActionController::API
    def home
        render json: "You are not authorized to access this location"
    end
    
end
