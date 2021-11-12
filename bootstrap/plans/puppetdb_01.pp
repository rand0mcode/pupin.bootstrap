# This plan is a part of bootstrap::all and represents the steps for the puppetdb
plan bootstrap::puppetdb_01 (
  String $domain,
  TargetSpec $targets,
){
  out::message('### initialize PuppetDB')
  run_task('bootstrap::create_csr_attributes', $targets, { role => 'puppet::db'})
  # disable centos postgres stream to use postgres upstream repositoeries
  run_command('dnf module disable -y -q postgresql', $targets)
  run_command('dnf clean all', $targets)
  # run puppet on puppetdb and install/configure puppetdb
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'environment', value => 'bootstrap' })
  run_plan('puppet_agent::run', $targets)
  # run puppet on puppetserver to use the puppetdb
  run_task('puppet_conf', 'puppet', { action => 'set', section => 'agent', setting => 'environment', value => 'bootstrap' })
  run_plan('puppet_agent::run', 'puppet')
  # switch back to standard environment
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'environment', value => 'production' })
  run_task('puppet_conf', 'puppet', { action => 'set', section => 'agent', setting => 'environment', value => 'production' })
}
