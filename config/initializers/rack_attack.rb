# for more settings or checks see: https://github.com/kickstarter/rack-attack

# Throttle requests to 5 requests per second per ip
unless Rails.env.test?
  Rack::Attack.throttle('req/ip', :limit => 15, :period => 1.second) do |req|
    # If the return value is truthy, the cache key for the return value
    # is incremented and compared with the limit. In this case:
    #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
    #
    # If falsy, the cache key is neither incremented nor checked.

    req.ip
  end

  # Throttle login attempts for a given email parameter to 6 reqs/minute
  # Return the email as a discriminator on POST /users/sign_in requests
  Rack::Attack.throttle('users/sign_in', :limit => 6, :period => 60.seconds) do |req|
    req.params['user']['login'] if req.path == 'users/sign_in' && req.post?
  end
end
