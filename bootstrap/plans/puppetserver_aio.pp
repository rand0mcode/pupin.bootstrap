# This plan is a part of bootstrap::all and represents the aio installation of a puppet environment
plan bootstrap::puppetserver_aio (
  String $control_repo,
  TargetSpec $targets,
){
  out::message('### initialize Puppetserver')

  # install puppetserver package
  run_task('package', $targets, { action => 'install', name => 'puppetserver' })
  run_task('package', $targets, { action => 'install', name => 'jq' })  # install jq for json pdb queries
  run_task('package', $targets, { action => 'install', name => 'git' }) # install git for r10k

  # does not work, provider is not excepted in the right way
  # run_task('package', $targets, { 'action' => 'install', 'name' => 'r10k', 'provider' => 'puppet_gem' })
  run_command('puppet resource package r10k ensure=installed provider=puppet_gem', $targets)

  # disable centos postgres stream to use postgres upstream repositoeries
  run_command('dnf module disable -y -q postgresql', $targets)
  run_command('dnf clean all', $targets)

  # create csr attributes and set role
  run_task('bootstrap::create_csr_attributes', $targets, { role => 'puppet::aio'})

  # start puppetserver service
  run_task('service', $targets, { action => 'start', name => 'puppetserver'})

  # configure r10k and control-repo
  run_task('bootstrap::r10k_config', $targets, { control_repo => $control_repo })

  # deploy puppetfile
  run_task('bootstrap::r10k_deploy', $targets)

  # run puppet and install/configure puppetdb
  run_plan('puppet_agent::run', $targets)
}
