::SecureHeaders::Configuration.configure do |config|
  # config.hsts = {:max_age => "631138519", :include_subdomain => false}
  config.hsts = false
  config.x_frame_options = 'DENY'
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = {:value => 1, :mode => false}
  config.csp = {
    :default_src => "self",
    :report_uri  => '//hospitium.co/content_security_policy/forward_report',
    :img_src     => "*",
    :script_src  => ['*.googleapis.com', 
                     '*.olark.com', 
                     '*.google-analytics.com', 
                     '*.gstatic.com', 
                     'localhost:3000', 
                     'd1pm9e0xzdmxcb.cloudfront.net', 
                     'd4uktpxr9m70.cloudfront.net',
                     'd1ros97qkrwjf5.cloudfront.net',
                     '*.newrelic.com',
                     '*.disqus.com', 
                     'inline',
                     'juggernaut-hospitium2.herokuapp.com',
                     'eval'],
    :style_src   => ['*.googleapis.com', 
                     '*.olark.com', 
                     'localhost:3000', 
                     'd1pm9e0xzdmxcb.cloudfront.net', 
                     'd4uktpxr9m70.cloudfront.net', 
                     'inline',
                     'maxcdn.bootstrapcdn.com'],
    :font_src    => ['*.googleusercontent.com',
                     'fonts.gstatic.com',
                     'd1pm9e0xzdmxcb.cloudfront.net',
                     'localhost:3000',
                     'maxcdn.bootstrapcdn.com'],
    :connect_src => ['*.olark.com', 
                     'juggernaut-hospitium2.herokuapp.com', 
                     'localhost:3000',
                     'hospitium.co'],
    :frame_src   => ['*.olark.com', 
                     '*.youtube.com',
                     'juggernaut-hospitium2.herokuapp.com', 
                     '*.disqus.com'],
    :media_src   => ['*.olark.com']
  }
end