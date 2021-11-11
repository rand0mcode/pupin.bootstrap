#!/opt/puppetlabs/puppet/bin/ruby

require 'yaml'
require 'json'
require 'fileutils'

params       = JSON.parse(STDIN.read)
control_repo = params['control_repo']
file_path    = '/etc/puppetlabs/r10k/r10k.yaml'

FileUtils.mkdir_p '/etc/puppetlabs/r10k'
FileUtils.mkdir_p '/var/cache/r10k'

r10k_config = {
  cachedir: '/var/cache/r10k',
  sources: {
    puppet: {
      remote: control_repo,
      basedir: '/etc/puppetlabs/code/environments'
    }
  }
}.to_yaml

File.open(file_path, 'w') { |file| file.write(r10k_config) }
