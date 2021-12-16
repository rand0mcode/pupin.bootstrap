# This plan add nodes to the puppet environment
plan bootstrap::add (
  String $collection       = 'puppet7',
  String $domain           = 'priv.example42.cloud',
  String $locale           = 'de',
  String $role             = 'default',
  TargetSpec $targets      = [],
){
  run_plan('bootstrap::prerequirements', $targets, { collection => $collection, locale => $locale, domain => $domain })
  run_task('bootstrap::create_csr_attributes', $targets, { role => $role })
  run_plan('puppet_agent::run', $targets) # Generate cert and send to CA
  get_targets($targets).each |$target| { run_task('bootstrap::sign_cert', 'puppetca', { certname => "${target.name}.${domain}" }) }
  run_plan('puppet_agent::run', $targets) # Download cert and apply cataloge
}
