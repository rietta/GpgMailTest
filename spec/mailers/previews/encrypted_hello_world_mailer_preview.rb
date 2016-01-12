# Preview all emails at http://localhost:3000/rails/mailers/encrypted_hello_world_mailer
class EncryptedHelloWorldMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/encrypted_hello_world_mailer/hello
  def hello
    EncryptedHelloWorldMailer.hello
  end

end
