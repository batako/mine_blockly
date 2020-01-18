module TestHelpers
  def sign_in(user, options = {})
    user = create(user, options) unless user.kind_of? User
    @current_user = user
    User.current  = @current_user
  end
end
