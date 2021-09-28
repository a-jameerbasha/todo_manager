# users_controller.rb
class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render plain: User.order(:id).map { |user| user.to_pleasant_string }.join("\n")
  end

  #Function to check if given email and password in user table
  #Input paramaters: user_email, user_password
  #Output: True / False
  def login
    user_email = params[:user_email]
    user_password = params[:user_password]
    response = User.exists?(user_email: user_email, user_password: user_password)
    render plain: response
  end

  def show
    id = params[:id]
    user = User.find(id)
    render plain: user.to_pleasant_string
  end

  def create
    user_name = params[:user_name]
    user_email = params[:user_email]
    user_password = params[:user_password]
    new_user = User.create!(
      user_name: user_name,
      user_email: user_email,
      user_password: user_password,
    )
    response_text = "New user is added to the DB with id: #{new_user.id}"
    render plain: response_text
  end
end
