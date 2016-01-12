require "rails_helper"

RSpec.describe 'EncryptedMailInterceptor' do
  it 'Encrypts a presented message' do
    interceptor = EncryptedMailInterceptor.new(EncryptedHelloWorldMailer.hello)
    expect {
      interceptor.encrypted_message
    }.to_not raise_error
    expect(interceptor.encrypted_message.to_s).to include EncryptedMailInterceptor::PGP_OPENING
  end

  describe 'Outgoing plaintext converted to ciphertext' do
    let(:ciphermessage) { EncryptedMailInterceptor.delivering_email(EncryptedHelloWorldMailer.hello) }

    it 'The encrypted message starts with the PGP opening line' do
      expect(ciphermessage.to_s).to include EncryptedMailInterceptor::PGP_OPENING
    end

    it 'The mime type is not plain text, but encrypted' do
      expect(ciphermessage.content_type).to eq 'application/pgp-encrypted'
    end
  end

  describe 'Outgoing HTML converted to ciphertext' do
    let(:ciphermessage) {
        EncryptedMailInterceptor.delivering_email(EncryptedHelloWorldMailer.html_single_part_message)
      }

    it 'The encrypted message starts with the PGP opening line' do
      expect(ciphermessage.to_s).to include EncryptedMailInterceptor::PGP_OPENING
    end

    it 'The mime type is not plain text, but encrypted' do
      expect(ciphermessage.content_type).to eq 'application/pgp-encrypted'
    end
  end
end
