raise 'PGP public keys must be supplied in the RECIPIENT_PGP_KEYS environment variable' unless ENV['RECIPIENT_PGP_KEYS']
RECIPIENT_PGP_KEYS=JSON.parse(ENV['RECIPIENT_PGP_KEYS'])
