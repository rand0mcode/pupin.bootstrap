# This plan is a part of bootstrap::all and represents the first steps for the puppetserver
plan bootstrap::puppetserver_01 (
  String $domain,
  TargetSpec $targets,
){
  out::message('### initialize Puppetserver - Part 1/2')

  # create csr attributes and set role
  run_task('bootstrap::create_csr_attributes', $targets, { role => 'puppet::compiler'})

  # install puppetserver package
  run_task('package', $targets, { action => 'install', name => 'puppetserver' })

  # set server to ca for first run to get certificates
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'server', value => "puppetca.${domain}" })

  # set dns altname
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'dns_alt_names', value => "puppet.${domain}" })

  # disable ca on server, we use an external ca
  run_task('bootstrap::disable_ca', $targets)

  # run puppet to get certificates from puppetca
  run_plan('puppet_agent::run', $targets)

  # switch puppet conf to oneself
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'server', value => "puppet.${domain}" })

  # start puppetserver service
  run_task('service', $targets, { action => 'start', name => 'puppetserver'})
}
