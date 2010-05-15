# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_CataMonitor_session',
  :secret      => '7f0d7b9c5328f6f615935f3ee46b78be32bddde48e78d672b9ab73b567deabc69cc11123b84077a5ad2f918c3999334d6a2777d00e176f9fbad8905e2b8b2e3b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
