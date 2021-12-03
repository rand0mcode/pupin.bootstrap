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
}
