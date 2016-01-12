require "rails_helper"

RSpec.describe EncryptedHelloWorldMailer, type: :mailer do
  describe "hello" do
    let(:mail) { EncryptedHelloWorldMailer.hello }

    it "renders the headers" do
      expect(mail.subject).to include "Test Encrypted Message / "
      expect(mail.to).to eq(RECIPIENT_PGP_KEYS.keys)
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

  describe 'Renders HTML only email as a single body' do
    let(:mail) { EncryptedHelloWorldMailer.html_single_part_message }

    it 'body includes html tags' do
      expect(mail.body.encoded).to include '<strong>'
    end

    it 'only a singe part' do
      expect(mail.parts.count).to eq 0
    end
  end

end
