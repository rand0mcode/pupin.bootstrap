#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'uri'
require 'net/http'

params   = JSON.parse(STDIN.read)
payload  = { override: true, refresh_fields: true, index_pattern: { title: params['pattern'] } }
uri      = URI("http://#{params['kibana_host']}:#{params['kibana_port']}/api/index_patterns/index_pattern")
req      = Net::HTTP::Post.new(uri, {'Content-Type' => 'application/json', 'kbn-xsrf' => 'reporting'})
req.body = payload.to_json
res      = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

exit 1 if res.code != '200'
puts JSON.parse(res.body)['index_pattern']['id'] if res.code == '200'

exit 0
