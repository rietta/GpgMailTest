require "rails_helper"

RSpec.describe EncryptedMailInterceptor do
  it 'Encrypts a presented message' do
    interceptor = EncryptedMailInterceptor.new(EncryptedHelloWorldMailer.hello)
    expect(interceptor.message).to_not raise_error
    expect(interceptor.message.to_s).to include? EncryptedMailInterceptor::PGP_OPENING
  end
end
