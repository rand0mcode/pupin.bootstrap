# This plan add nodes to the puppet environment
plan bootstrap::add (
  String $collection       = 'puppet7',
  String $domain           = 'priv.rw.betadots.training',
  String $locale           = 'de',
  String $role             = 'default',
  TargetSpec $targets      = [],
){
  # make sure puppet is installed
  run_plan('bootstrap::prerequirements', $targets, { collection => $collection, locale => $locale, domain => $domain })

  # create csr atributes file with role
  run_task('bootstrap::create_csr_attributes', $targets, { role => $role })

  # switch to empty environment to not get any configuration in the first place
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'environment', value => 'empty' })

  # Generate cert and send to CA
  run_plan('puppet_agent::run', $targets)

  # sign cert on puppetca
  get_targets($targets).each |$target| { run_task('bootstrap::sign_cert', 'puppetca', { certname => "${target.name}.${domain}" }) }

  # Download cert and apply cataloge
  run_plan('puppet_agent::run', $targets)

  # switch back to production environment
  run_task('puppet_conf', $targets, { action => 'set', section => 'agent', setting => 'environment', value => 'production' })
}
