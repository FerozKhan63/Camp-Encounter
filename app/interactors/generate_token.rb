class GenerateToken
  include Interactor

  def call
    raw, enc = Devise.token_generator.generate(context.model_name, context.token)
    context.user.reset_password_token   = enc
    context.user.reset_password_sent_at = Time.current

    if context.user.save
      context.raw = raw
    else
      context.fail!(error: "There were some errors in the form you submitted please submit with the correct details.")
    end
  end
end
