class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    if user = User.find_by(email: params[:email])
      render json: {message: "User already exist", user_id: user.id}
    else
      user = User.new(email: params[:email], first_name: params[:first_name], last_name: params[:last_name], image: params[:image])
      user.save
      if user
        render json: {message: "User created successfully", user_id: user.id }
      else
        render json: {message: "User not created"}
      end
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(street_address_1: params[:street_address_1], street_address_2: params[:street_address_2], city: params[:city], state: params[:state])
      render json: {message: "User successfully updated"}
    else
      render json: {message: "User not updated"}
    end
  end
end
