# This plan is a part of bootstrap::all and represents the third steps for the puppetca
plan bootstrap::puppetca_03 (
  TargetSpec $targets,
){
  out::message('### initialize PuppetCA - Part 3/3')
  # Disable autosign on puppetca
  run_task('puppet_conf', $targets, { action => 'set', section => 'server', setting => 'autosign', value => 'false' })
  # restart puppetsever service
  run_task('service', $targets, { action => 'restart', name => 'puppetserver' })
}
