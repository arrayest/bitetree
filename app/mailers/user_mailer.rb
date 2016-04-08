class UserMailer < Devise::Mailer
  def confirmation_instructions(record, token, opts={})
    begin
      @token = token
      devise_mail(record, :confirmation_instructions, opts)
    rescue => e
    end
  end

  def reset_password_instructions(record, token, opts={})
    begin
      @token = token
      devise_mail(record, :reset_password_instructions, opts)
    rescue => e
    end
  end

  def unlock_instructions(record, token, opts={})
    begin
      @token = token
      devise_mail(record, :unlock_instructions, opts)
    rescue => e
    end
  end
end
