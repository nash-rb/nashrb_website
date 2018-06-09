class UsersController < ApplicationController
  public_permissions only: %i(new create)

  attr_reader :user_create
  helper_method :user_create

  # Sign up form (start)
  def new
    @user_create = User::Create.new
  end

  # Sign up (complete)
  def create
    @user_create = User::Create.new(**user_create_params)
    if @user_create.call(session)
      redirect_to root_path
    else
      render :new
    end
  end

  # Profile page (needed?)
  def show; end

private

  def user_create_params
    params
      .require(:user)
      .permit(:email, :password, :password_confirmation, :first_name, :last_name)
      .to_h
      .symbolize_keys
  end
end
