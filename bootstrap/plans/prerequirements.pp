# This plan is a part of bootstrap::all and represents the steps which are pre required to run
plan bootstrap::prerequirements (
  String $collection,
  String $domain,
  String $locale,
  TargetSpec $targets,
){
  out::message('### perpare environment, installing puppet-agent')

  # install puppet agent
  run_task('puppet_agent::install', $targets, { collection => $collection })

  # install locales to get working environment for yum and postgres
  run_task('package', $targets, { action => 'install', name => "glibc-langpack-${locale}" })

  get_targets($targets).each |$target| {
    $puppet_conf = {
      certname    => "${target}.${domain}",
      server      => "puppet.${domain}",
      ca_server   => "puppetca.${domain}",
      environment => 'production',
    }

    $puppet_conf.each |$setting, $value| {
      run_task('puppet_conf', $target, { action  => 'set', section => 'agent', setting => $setting, value => $value })
    }
  }
}
