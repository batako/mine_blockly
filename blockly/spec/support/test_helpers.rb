module TestHelpers
  def sign_in(user, options = {})
    user = create(user, options) unless user.kind_of? User
    User.authenticate!(user.login_id)
    allow_any_instance_of(ActionDispatch::Request).to \
      receive(:session).and_return(token: User.current.token)
  end
end
