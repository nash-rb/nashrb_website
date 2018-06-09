module Authenticated
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    helper_method :current_user, :signed_in?
  end

  class_methods do
    def public_permissions(*options)
      skip_before_action :authenticate_user!, *options
    end
  end

  def current_user
    Users.from_session(session)
  end

  def signed_in?
    current_user.authenticated?
  end

  def authenticate_user!
    return if signed_in?

    redirect_to sign_in_path
  end
end