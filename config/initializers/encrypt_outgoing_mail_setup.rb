
class EncryptedMailInterceptor

  PGP_ERROR       = 'Must be an OpenPGP encrypted message.'
  PGP_OPENING     = '-----BEGIN PGP MESSAGE-----'
  PGP_ENDING      = '-----END PGP MESSAGE-----'
  PGP_MIME_TYPE   = 'application/pgp-encrypted'

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

  private

  def encrypt_message
    fail 'Multi-part messages not supported!' unless @message.parts.count == 0
    plaintext = @message.body.raw_source
    ciphertext = encrypt_text(plaintext)
    @message.body = ciphertext
    @message.content_type = PGP_MIME_TYPE
    @message
  end

  def encrypt_text(message, recipient_keys = RECIPIENT_PGP_KEYS.values)
    crypto = GPGME::Crypto.new(armor: true)
    crypto.encrypt(message, recipients: recipient_keys).to_s
  end

end


ActionMailer::Base.register_interceptor(EncryptedMailInterceptor)
