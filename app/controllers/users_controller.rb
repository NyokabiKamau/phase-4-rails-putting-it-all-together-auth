class UsersController < ApplicationController
    
    # POST '/signup'
    def create
        user = User.create(user_params)
        if user.valid?
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: { errors: ["unprocessable_entity", "Please try again"] }, status: 422
        end
    end

    # GET '/me'
    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user, status: :created
        else
            render json: {error: "Please login"}, status: :unauthorized
        end

    end

    private

    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

end
