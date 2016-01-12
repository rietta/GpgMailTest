class EncryptedHelloWorldMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.encrypted_hello_world_mailer.hello.subject
  #
  def hello
    n = DateTime.now
    @greeting = "Hi\n\nThe secret number is #{SecureRandom.hex(10)}. The time is #{n}."

    mail to: RECIPIENT_PGP_KEYS.keys, from: 'encrypted_hello_world@example.com', subject: "Test Encrypted Message / #{n}"
  end
end
