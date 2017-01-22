class Sanitize
  module Config
    ULTRARELAXED = {
      elements: %w(
        a b blockquote br caption cite code col
        colgroup dd dl dt em h1 h2 h3 h4 h5 h6
        i img li ol p pre q small strike strong
        sub sup table tbody td tfoot th thead tr u
        ul object embed param iframe script
      ),

      attributes: {
        'a'          => %w(href title),
        'blockquote' => ['cite'],
        'col'        => %w(span width),
        'colgroup'   => %w(span width),
        'img'        => %w(align alt height src title width),
        'ol'         => %w(start type),
        'q'          => ['cite'],
        'table'      => %w(summary width),
        'td'         => %w(abbr axis colspan rowspan width),
        'th'         => %w(abbr axis colspan rowspan scope
                           width),
        'ul'         => ['type'],
        'object' => %w(width height),
        'param'  => %w(name value),
        'embed'  => %w(src type allowscriptaccess allowfullscreen width height flashvars),
        'iframe' => %w(src width height frameborder),
        'script' => ['src']
      },

      protocols: {
        'a'          => { 'href' => ['ftp', 'http', 'https', 'mailto', :relative] },
        'blockquote' => { 'cite' => ['http', 'https', :relative] },
        'img'        => { 'src'  => ['http', 'https', :relative] },
        'q'          => { 'cite' => ['http', 'https', :relative] }
      },

      transformers: ->(env) { next unless env[:node_name] == 'script'; unless env[:node]['src'] && env[:node]['src'].include?('http://player.ooyala.com'); Sanitize.clean_node!(env[:node], {}); end; nil }
    }.freeze
    YOUTUBE = {

      transformers: lambda do |env|
                      node = env[:node]
                      node_name = env[:node_name]

                      # Don't continue if this node is already whitelisted or is not an element.
                      return if env[:is_whitelisted] || !node.element?

                      # Don't continue unless the node is an iframe.
                      return unless node_name == 'iframe'

                      # Verify that the video URL is actually a valid YouTube or Facebook video URL.
                      return unless node['src'] =~ /\Ahttp?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\// ||
                                    node['src'] =~ /\Ahttps?:\/\/(?:www\.)?youtube(?:-nocookie)?\.com\// ||
                                    node['src'] =~ %r{\A(?:https?:)?//(?:www\.)?youtube(?:-nocookie)?\.com/} ||
                                    node['src'] =~ %r{\A(?:https?:)?//(?:www\.)?facebook?\.com/} ||
                                    node['src'] =~ /\Ahttps?:\/\/(?:www\.)?facebook?\.com\//

                      # We're now certain that this is a YouTube embed, but we still need to run
                      # it through a special Sanitize step to ensure that no unwanted elements or
                      # attributes that don't belong in a YouTube embed can sneak in.
                      Sanitize.clean_node!(node, elements: %w(iframe),

                                                 attributes: {
                                                   'iframe' => %w(allowfullscreen frameborder src width height)
                                                 })

                      # Now that we're sure that this is a valid YouTube embed and that there are
                      # no unwanted elements or attributes hidden inside it, we can tell Sanitize
                      # to whitelist the current node.
                      { node_whitelist: [node] }
                    end
    }.freeze
  end
end
