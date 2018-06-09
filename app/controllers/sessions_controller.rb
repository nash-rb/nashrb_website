class SessionsController < ApplicationController
  public_permissions only: %i(new create)

  attr_reader :session_create
  helper_method :session_create

  # Sign in form (start)
  def new
    @session_create = Session::Create.new
  end

  # Sign in (complete)
  def create
    @session_create = Session::Create.new(**session_create_params)
    if @session_create.call(session)
      redirect_to root_url
    else
      render :new
    end
  end

  # Sign out
  def destroy
    session.destroy
    redirect_to root_path
  end

private

  def session_create_params
    params
      .require(:session)
      .permit(:email, :password)
      .to_h
      .symbolize_keys
  end
end
