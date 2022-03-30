# This plan is a part of bootstrap::all and represents the second steps for the puppetca
plan bootstrap::puppetca_02 (
  String $domain,
  TargetSpec $targets,
){
  out::message('### initialize PuppetCA - Part 2/3')

  # disable allow-subject-alt-name again
  run_task('bootstrap::set_alt_names', $targets, { alt_names => false })

  # switch puppet conf to final server settings
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'server', value => "puppet.${domain}" })
  run_task('service', $targets, { action => 'restart', name => 'puppetserver'})
}
