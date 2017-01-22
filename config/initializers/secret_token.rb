# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
AnimalTracker::Application.config.secret_token = ENV['SECRET_TOKEN'] || 'e72cfc2ec078e5159e345ef9dcf7cd099d6f3e53df10b63b05829804c4230967c4dcc43bdca490d52ddffa3bd691e7fceba7eee83fa5ff6de9f315691395bfaf'
AnimalTracker::Application.config.secret_key_base = ENV['SECRET_TOKEN'] || 'ba0kg7k3UiKubGeGdjjKQI7p9KC1MRd8AYKtrWG6eluEfUVf7yEn0hRXbLzNI8ebQgopjwgxmPN4mu0torClcnGgs3dsZwMZuZBR7qUrwlIjxWcTQYuxothoLf8f9a'
