#!/opt/puppetlabs/puppet/bin/ruby

require 'yaml'
require 'json'
require 'fileutils'

params       = JSON.parse(STDIN.read)
control_repo = params['control_repo']
file_path    = '/etc/puppetlabs/r10k/r10k.yaml'
cache_dir    = '/opt/puppetlabs/puppet/cache/r10k'

FileUtils.mkdir_p '/etc/puppetlabs/r10k'
FileUtils.mkdir_p cache_dir

r10k_config = {
  cachedir: cache_dir,
  sources: {
    puppet: {
      remote: control_repo,
      basedir: '/etc/puppetlabs/code/environments',
      deploy: {
        generate_types: true,
      }
    }
  }
}.to_yaml

File.open(file_path, 'w') { |file| file.write(r10k_config) }
