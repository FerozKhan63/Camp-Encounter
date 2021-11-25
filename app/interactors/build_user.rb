class BuildUser
  include Interactor

  def call
    user = User.new(context.user_params)
    user.skip_password_validation = true
    user.skip_confirmation!

    if user
      context.user = user
    else
      context.fail!
    end
  end
end
