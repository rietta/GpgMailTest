require "rails_helper"

RSpec.describe 'EncryptedMailInterceptor' do
  it 'Encrypts a presented message' do
    interceptor = EncryptedMailInterceptor.new(EncryptedHelloWorldMailer.hello)
    expect {
      interceptor.encrypted_message
    }.to_not raise_error
    expect(interceptor.encrypted_message.to_s).to include EncryptedMailInterceptor::PGP_OPENING
  end

  it 'Implements the interceptor' do
    expect(EncryptedMailInterceptor.delivering_email(EncryptedHelloWorldMailer.hello).to_s).to include EncryptedMailInterceptor::PGP_OPENING
  end

  it 'The mime type is not plain text, but encrypted' do
    expect(EncryptedMailInterceptor.delivering_email(EncryptedHelloWorldMailer.hello).content_type).to eq 'application/pgp-encrypted'
  end
end
