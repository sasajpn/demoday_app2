if defined?(ActionMailer)
  class Devise::Mailer < Devise.parent_mailer.constantize
    include Devise::Mailers::Helpers

    def confirmation_instructions(record, token, opts = {})
      @token = token
      devise_mail(record, :confirmation_instructions, opts)
    end

    def reset_password_instructions(record, token, opts = {})
      @token = token
      devise_mail(record, :reset_password_instructions, opts)
    end

    def confirmation_on_create_instructions(record, token, opts = {})
      @token = token
      devise_mail(record, :confirmation_on_create_instructions, opts)
    end
  end
end
