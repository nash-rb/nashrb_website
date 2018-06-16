class AuthenticatedUser < SimpleDelegator
  def authenticated?
    true
  end
end
