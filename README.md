# Encrypt Outgoing E-mail using ActionMailer and GnuPG/OpenPGP/PGP

## Overview
This tech demo project is a companion to https://github.com/rietta/GpgMeTest. Whereas GpgMeTest
focused on practical PGP encryption for storage, this focuses on implementing an application-wide
mail interceptor that encrypts outgoing mail.

## Usage
*encrypt_outgoing_mail_setup.rb* is added to the config/initializers. To define EncryptedMailInterceptor
and register it as the mail interceptor for this Rails application. Once in place, the interceptor processes
every ActionMailer message and encrypts the outgoing mail if there is a key available.

This project only has the most basic interceptor interface defined. Once registered, the interceptor
must process all messages, but it is not required to modify all. So presumably, one could define a plaintext mailer
by setting a "plaintext_is_okay" header in the mailer and have the interceptor look for that.

## Design Challenges


## Dependencies
- gnupg
  - sudo apt-get install gpg
  - brew install gpg

- gpgme
  - sudo apt-get install libgpgme11-dev
  - brew install gpgme


# Cryptographic Concerns

## Crypto-system in place
This system does not invent its own crypto, but uses GnuPG, that implements the OpenPGP standard.

## Shamir’s Law: Crypto is bypassed, not penetrated
> Cryptography is usually bypassed. I am not aware of any major world-class security system employing cryptography in which the hackers penetrated the system by actually going through the cryptanalysis [...] usually there are much simpler ways of penetrating the security system -- Adi Shamir


# License and Copyright
## Third-Party Licenses
This project makes use of the [ruby-gpgme gem](https://github.com/ueno/ruby-gpgme/), that is licensed under the terms of the GNU Lesser Public License.

## Our License
Copyright © 2016 Rietta Inc. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
- Neither the name of the Rietta nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RIETTA BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
