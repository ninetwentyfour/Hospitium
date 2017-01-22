SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  # Add "; preload" and submit the site to hstspreload.org for best protection.
  config.hsts = SecureHeaders::OPT_OUT
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = "origin-when-cross-origin"
  config.clear_site_data = [
    "cache",
    "cookies",
    "storage",
    "executionContexts"
  ]
  # config.csp = SecureHeaders::OPT_OUT
  # This is available only from 3.5.0; use the `report_only: true` setting for 3.4.1 and below.
  # config.csp_report_only = {
  config.csp = {
    # "meta" values. these will shaped the header, but the values are not included in the header.
    report_only: true,      # default: false [DEPRECATED from 3.5.0: instead, configure csp_report_only]
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.

    # directive values: these values will directly translate into source directives
    default_src: %w('self'),
    base_uri: %w('self'),
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w('self' *.olark.com *.youtube.com juggernaut-hospitium2.herokuapp.com disqus.com), # if child-src isn't supported, the value for frame-src will be set.
    connect_src: %w(*.olark.com juggernaut-hospitium2.herokuapp.com localhost:3000 ws://localhost:3000/ wss://hospitium.co/ hospitium.co),
    font_src: %w('self' *.googleusercontent.com fonts.gstatic.com d1pm9e0xzdmxcb.cloudfront.net localhost:3000 maxcdn.bootstrapcdn.com),
    form_action: %w('self' github.com),
    frame_ancestors: %w(*.olark.com *.youtube.com juggernaut-hospitium2.herokuapp.com *.disqus.com),
    img_src: %w(* data:),
    media_src: %w(*.olark.com),
    object_src: %w('self'),
    plugin_types: %w(application/x-shockwave-flash),
    script_src: %w('self' *.googleapis.com *.olark.com *.google-analytics.com *.gstatic.com localhost:3000 d1pm9e0xzdmxcb.cloudfront.net d4uktpxr9m70.cloudfront.net d1ros97qkrwjf5.cloudfront.net *.newrelic.com *.disqus.com bam.nr-data.net 'unsafe-eval'),
    style_src: %w('unsafe-inline' *.googleapis.com *.olark.com localhost:3000 d1pm9e0xzdmxcb.cloudfront.net d4uktpxr9m70.cloudfront.net maxcdn.bootstrapcdn.com *.disquscdn.com),
    upgrade_insecure_requests: false, # see https://www.w3.org/TR/upgrade-insecure-requests/
    report_uri: %w(https://hospitium.report-uri.io/r/default/csp/reportOnly)
  }
  config.hpkp = SecureHeaders::OPT_OUT
  # config.hpkp = {
  #   report_only: true,
  #   max_age: 60.days.to_i,
  #   include_subdomains: true,
  #   report_uri: "https://hospitium.report-uri.io/r/default/hpkp/reportOnly",
  #   pins: [
  #     {sha256: "abc"},
  #     {sha256: "123"}
  #   ]
  # }
end
