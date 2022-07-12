# This plan is a part of bootstrap::all and represents the steps which are pre required to run
plan bootstrap::prerequirements (
  String $collection,
  String $domain,
  String $env,
  String $locale,
  String $type,
  TargetSpec $targets,
) {
  out::message('### perpare environment, installing puppet-agent')

  # install puppet agent
  run_task('puppet_agent::install', $targets, { collection => $collection })

  # install locales to get working environment for yum and postgres
  run_task('package', $targets, { action => 'install', name => "glibc-langpack-${locale}" })

  # install convenience tools
  run_task('package', $targets, { action => 'install', name => 'vim' })

  # set yum to use only ipv4 to not get blocked bei elastic on ipv6
  # they give you sometimes a http 403 when you want to install a
  # package over ipv6
  apply($targets) {
    augeas { 'yum.conf_ip_resolve':
      incl    => '/etc/yum.conf',
      lens    => 'Yum.lns',
      context => '/files/etc/yum.conf/main/',
      changes => ' set ip_resolve 4',
    }
  }

  get_targets($targets).each |$target| {
    apply($target) { host { "${target}.${domain}": ensure => absent } } # remove ipv4 host alias
    apply($target) { host { "${target}.${domain}": ensure => absent } } # remove ipv6 host alias

    case $type {
      'ext_ca_pdb_oss': {
        $puppet_conf = {
          certname    => "${target}.${domain}",
          server      => "puppet.${domain}",
          ca_server   => "puppetca.${domain}",
          environment => $env,
        }
      }
      'aio_oss': {
        $puppet_conf = {
          certname    => "${target}.${domain}",
          server      => "puppet.${domain}",
          environment => $env,
        }
      }
      default: { fail("Type: \"${type}\" is not supported!") }
    }

    $puppet_conf.each |$setting, $value| {
      run_task('puppet_conf', $target, { action  => 'set', section => 'agent', setting => $setting, value => $value })
    }
  }

  # run_task('bootstrap::elk_disable_system_auditd', $targets)
}
