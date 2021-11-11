#!/opt/puppetlabs/puppet/bin/ruby

require 'json'
require 'hocon/parser/config_document_factory'
require 'hocon/config_value_factory'

params = JSON.parse(STDIN.read)
alt_names = params['alt_names']
file_path = '/etc/puppetlabs/puppetserver/conf.d/ca.conf'

ca_conf = Hocon::Parser::ConfigDocumentFactory.parse_file(file_path)
ca_conf = ca_conf.set_value("certificate-authority.allow-subject-alt-names", alt_names.to_s)
ca_conf = ca_conf.render # returns string

File.open(file_path, 'w') { |file| file.write(ca_conf) }
