# This plan is a part of bootstrap::all and represents the second steps for the puppetserver
plan bootstrap::puppetserver_02 (
  String $control_repo,
  TargetSpec $targets,
){
  out::message('### initialize Puppetserver - Part 2/2')

  # does not work, provider is not excepted in the right way
  # run_task('package', $targets, { 'action' => 'install', 'name' => 'r10k', 'provider' => 'puppet_gem' })
  run_command('puppet resource package r10k ensure=installed provider=puppet_gem', $targets)

  # install git for r10k
  run_task('package', $targets, { action => 'install', name => 'git' })

  # configure r10k and control-repo
  run_task('bootstrap::r10k_config', $targets, { control_repo => $control_repo })

  # deploy puppetfile
  run_task('bootstrap::r10k_deploy', $targets)
}
