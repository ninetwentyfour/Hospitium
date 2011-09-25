# Be sure to restart your server when you modify this file.

#AnimalTracker::Application.config.session_store :cookie_store, :key => '_animal_tracker_session'
AnimalTracker::Application.config.session_store :dalli_store
#AnimalTracker::Application.config.session_store :mem_cache_store
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# AnimalTracker::Application.config.session_store :active_record_store
