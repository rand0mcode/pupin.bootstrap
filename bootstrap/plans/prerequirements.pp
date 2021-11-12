# This plan is a part of bootstrap::all and represents the steps which are pre required to run
plan bootstrap::prerequirements (
  TargetSpec $targets,
  String $collection,
  String $locale,
){
  out::message('### perpare environment, installing puppet-agent')
  # install puppet agent
  run_task('puppet_agent::install', $targets, { collection => $collection })
  # install locales to get working environment for yum and postgres
  run_task('package', $targets, { action => 'install', name => "glibc-langpack-${locale}" })
}
