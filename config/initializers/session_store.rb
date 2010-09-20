# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_images_session',
  :secret      => '9c5ee83e1353429365c6e7205622a2a76bd6ed643c409078b4a9324a9a6b40915210e4358c00fabca3f3ec1dde152c57dfae201daa0462e1350e89c8ca75295a'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
