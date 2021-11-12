# This plan is a part of bootstrap::all and represents the first steps for the puppetca
plan bootstrap::puppetca_01 (
  String $domain,
  TargetSpec $targets,
){
  out::message('### initialize PuppetCA - Part 1')
  # install puppetserver package
  run_task('package', $targets, { action => 'install', name => 'puppetserver' })
  # create csr attributes and set role
  run_task('bootstrap::create_csr_attributes', $targets, { role => 'puppet::ca'})
  # allow allow-subject-alt-name for the setup, will be disabled later
  run_task('bootstrap::set_alt_names', $targets, { alt_names => true })
  # set server to one self for the first run
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'server', value => "puppetca.${domain}" })
  # allow autosign for the setup
  run_task('puppet_conf', $targets, { action => 'set', section => 'server', setting => 'autosign', value => 'true' })
  # start puppetserver service
  run_task('service', $targets, { action => 'start', name => 'puppetserver'})
}
