module WorkspaceDecorator
  def user_name
    creator.login_id
  end
end
