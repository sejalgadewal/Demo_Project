# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #class Users::SessionsController < ApplicationController
  

  include RackSessionsFix

  def new
    #@user=User.new
    super
  end

  # def create
  #   @user = User.find_by(email: params[:session][:email])

  #   if @user && @user.password == params[:session][:password]
  #     session[:user_id] = @user.id
  #     render json: { message: 'Logged in successfully.' }, status: :ok

  #   else
  #     flash.now[:alert] = 'Invalid email or password.'
  #     render json: { error: 'Invalid email or password.' }, status: :unauthorized

  #   end
  # end

  # def destroy
  #   session[:user_id] = nil
  #   redirect_to root_path, notice: 'Logged out successfully.'
  # end

  # def create
  #   user = User.find_by(email: params[:email])
  #   if user && user.authenticate(params[:password])
  #     # Successful login
  #     session[:user_id] = user.id
  #     respond_with(user)
  #   else
  #     # Invalid login
  #     render json: { status: 401, message: 'Invalid credentials' }, status: :unauthorized
  #   end
  # end

  def create
    user = User.find_by(email: params[:user][:email])
    
    if user&.valid_password?(params[:user][:password])
      sign_in user

      redirect_to root_path
      # render json: { message: 'Logged in successfully.' }, status: :ok
    else
      render json: { status: 401, message: 'Invalid credentials' }, status: :unauthorized
    end
  end


  def destroy
    if current_user
      session[:user_id] = nil
      
      # respond_to_on_destroy
      # redirect_to new_user_registration_path, notice: 'Logged out successfully.'
    else
      render json: { status: 401, message: "Couldn't find an active session." }, status: :unauthorized
    end
  end



  # respond_to :json
  # private
  # def respond_with(current_user, _opts = {})
  #   render json: {
  #     status: { 
  #       code: 200, message: 'Logged in successfully.',
  #      data: { user: UserSerializer.new(current_user).serializable_hash[:data][:attributes] }
  #     }
  #   }, status: :ok
  # end


  # def respond_to_on_destroy
  #   if request.headers['Authorization'].present?
  #     jwt_payload = JWT.decode(request.headers['Authorization'].split(' ').last, Rails.application.credentials.devise_jwt_secret_key!).first
  #     current_user = User.find(jwt_payload['sub'])
  #   end
    
  #   if current_user
  #     render json: {
  #       status: 200,
  #       message: 'Logged out successfully.'
  #     }, status: :ok
  #   else
  #     render json: {
  #       status: 401,
  #       message: "Couldn't find an active session."
  #     }, status: :unauthorized
  #   end
  # end
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
