class ApplicationController < ActionController::API
    def home
        render json: "you are not subscribed"
    end
    
end
