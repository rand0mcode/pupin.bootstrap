#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'uri'
require 'net/http'

params  = JSON.parse(STDIN.read)
payload = {
  description: "parse puppetserver.log",
  version: 1,
  processors: [ {
    grok: {
      field: "message",
      patterns: [ "%{PUPPETTIMESTAMP}%{SPACE}%{PUPPETDETAILS}" ],
      pattern_definitions: {
        PUPPETTIMESTAMP:  "%{TIMESTAMP_ISO8601:puppet_timestamp}",
        PUPPETPROCESS:  "\\[%{DATA:puppet_process}\\]",
        PUPPETFACILITY:  "\\[%{DATA:puppet_facility}\\]",
        PUPPETDETAILS:  "%{LOGLEVEL:puppet_severity}%{SPACE}%{PUPPETPROCESS}%{SPACE}%{PUPPETFACILITY}%{SPACE}%{GREEDYDATA:puppet_message}"
      },
      # trace_match:  true,
      ignore_missing:  true,
      if:  "ctx.log.file.path == '/var/log/puppetlabs/puppetserver/puppetserver.log'",
      # ignore_failure:  true
    }
  } ]
}

uri      = URI("#{params['protocol']}://#{params['elastic_host']}:#{params['elastic_port']}/_ingest/pipeline/#{params['pipeline_name']}")
req      = Net::HTTP::Put.new(uri, { 'Content-Type' => 'application/json' })
req.body = payload.to_json
res      = Net::HTTP.start(uri.hostname, uri.port) { |http| http.request(req) }

fail "HTTP/#{res.code}: #{res.message} (#{res.error_type})" if res.code != '200'

puts res.body if res.code == '200'
