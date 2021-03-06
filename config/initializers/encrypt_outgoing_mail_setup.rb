##
# Encryptor that intercepts and encrypts outgoing e-mails sent through ActionMailer.
#
# Author: Frank Rietta
# Copyright 2016 Rietta Inc. Licensed under the terms of the BSD license.

class EncryptedMailInterceptor

  PGP_ERROR       = 'Must be an OpenPGP encrypted message.'
  PGP_OPENING     = '-----BEGIN PGP MESSAGE-----'
  PGP_ENDING      = '-----END PGP MESSAGE-----'
  PGP_MIME_TYPE   = 'application/pgp-encrypted'
  MULTIPART_ERROR = 'Multi-part messages not supported!'

  def self.delivering_email(message)
    interceptor = EncryptedMailInterceptor.new(message)
    interceptor.encrypted_message
  end

  def initialize(message)
    @message = message
  end

  def encrypted_message
    m = encrypt_message
    fail_on_plaintext m
    m
  end

  private

  def fail_on_plaintext(message)
    fail PGP_ERROR unless pgp_message?(message.body)
    if message.parts.any?
      message.parts.each do |part|
        fail PGP_ERROR unless pgp_message?(part.to_s)
      end
    end
  end

  def pgp_message?(ciphertext)
    lines = ciphertext.to_s.strip.split("\n")
    if lines.length > 1 and PGP_OPENING == lines.first and PGP_ENDING == lines.last
      true
    else
      false
    end
  end # pgp_message?

  def encrypt_message
    fail MULTIPART_ERROR unless @message.parts.count == 0
    plaintext = @message.body.raw_source
    ciphertext = encrypt_text(plaintext)
    @message.body = ciphertext
    @message.content_type = PGP_MIME_TYPE
    @message
  end

  def encrypt_text(message, recipient_keys = RECIPIENT_PGP_KEYS.values)
    crypto = GPGME::Crypto.new(armor: true)
    crypto.encrypt(message, recipients: recipient_keys, sign: true).to_s
  end

end # class EncryptedMailInterceptor

# Registers this interceptor with the Rails application.
ActionMailer::Base.register_interceptor(EncryptedMailInterceptor)
